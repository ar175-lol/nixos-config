{
  config,
  lib,
  ...
}: let
  cfg = config.modules.device.hasSound;
in {
  config = lib.mkIf cfg {
    services = {
      pulseaudio.enable = false;
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        jack.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
        extraConfig."pipewire-pulse"."10-block-source-volume" = {
          "pulse.rules" = [
            {
              matches = [
                {"application.name" = "equibop";}
                {"application.process.binary" = "electron";}
              ];
              actions.quirks = ["block-source-volume"];
            }
          ];
        };
        # Route every capture stream that browser opens to the
        # PipeWire Soundpad virtual mic, so soundpad audio reaches calls.
        # The browser asks for the physical mic by name, which a default-node
        # or pulse.rules target cannot override, so this is a WirePlumber
        # linking policy hook. PWSP mixes the physical mic into its virtual
        # mic, so calls still carry the user's voice.
        wireplumber.extraScripts."pwsp/force-capture.lua" = ''
          lutils = require ("linking-utils")
          cutils = require ("common-utils")
          log = Log.open_topic ("s-pwsp")

          SimpleEventHook {
            name = "pwsp/force-capture-target",
            before = "linking/find-defined-target",
            interests = {
              EventInterest {
                Constraint { "event.type", "=", "select-target" },
              },
            },
            execute = function (event)
              local source, om, si, si_props, si_flags, target =
                  lutils:unwrap_select_target_event (event)

              if target then
                return
              end

              if si_props ["media.class"] ~= "Stream/Input/Audio" then
                return
              end
              if si_props ["application.name"] ~= "LibreWolf" and
                  si_props ["application.process.binary"] ~= "librewolf" then
                return
              end

              for linkable in om:iterate { type = "SiLinkable" } do
                local props = linkable.properties
                if props ["node.name"] == "pwsp-virtual-mic" and
                    props ["item.node.direction"] ==
                        cutils.getTargetDirection (si_props) and
                    lutils.canLink (si_props, linkable) then
                  target = linkable
                  break
                end
              end

              if not target then
                return
              end

              local passthrough_compatible, can_passthrough =
                  lutils.checkPassthroughCompatibility (si, target)
              if not passthrough_compatible then
                return
              end

              si_flags.has_defined_target = true
              si_flags.has_node_defined_target = false
              si_flags.can_passthrough = can_passthrough
              event:set_data ("target", target)
              log:info (si, "... forced target: pwsp-virtual-mic")
            end
          }:register ()

          -- Re-evaluate streams when the virtual mic appears, so starting
          -- PWSP after a call has begun still routes the capture stream.
          SimpleEventHook {
            name = "pwsp/rescan-on-virtual-mic",
            interests = {
              EventInterest {
                Constraint { "event.type", "=", "session-item-added" },
                Constraint { "event.session-item.interface", "=", "linkable" },
              },
            },
            execute = function (event)
              local si = event:get_subject ()
              if si.properties ["node.name"] ~= "pwsp-virtual-mic" then
                return
              end
              event:get_source ():call ("schedule-rescan", "linking")
            end
          }:register ()
        '';
        wireplumber.extraConfig."51-pwsp-capture" = {
          "wireplumber.components" = [
            {
              name = "pwsp/force-capture.lua";
              type = "script/lua";
              provides = "pwsp.force-capture";
            }
          ];
          "wireplumber.profiles".main."pwsp.force-capture" = "required";
        };
      };
    };
    security.rtkit.enable = true;
  };
}

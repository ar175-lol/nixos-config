{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.niri;

  settings =
    {
      prefer-no-csd = true;

      animations = {
        workspace-switch.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 700;
            epsilon = 0.0001;
          };
        };
        window-movement.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 500;
            epsilon = 0.0001;
          };
        };
        window-resize.spring = _: {
          props = {
            damping-ratio = 0.8;
            stiffness = 400;
            epsilon = 0.0001;
          };
        };
        overview-open-close.spring = _: {
          props = {
            damping-ratio = 1.0;
            stiffness = 500;
            epsilon = 0.0001;
          };
        };
        window-open = {
          duration-ms = 220;
          curve = "ease-out-cubic";
        };
        window-close = {
          duration-ms = 180;
          curve = "ease-out-cubic";
        };
      };

      input = {
        keyboard = {
          xkb = {
            layout = "us,ru";
            options = "grp:alt_shift_toggle";
          };
          repeat-delay = 400;
          repeat-rate = 25;
        };
        touchpad = {
          tap = _: {};
          natural-scroll = _: {};
          dwt = _: {};
          click-method = "clickfinger";
          scroll-factor = 0.7;
        };
      };

      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

      layout = {
        focus-ring = {
          width = 2;
          active-color = "#cba6f7";
          inactive-color = "#1e1e2e";
          urgent-color = "#f38ba8";
        };
        border = {
          width = 1;
          active-color = "#cba6f7";
          inactive-color = "#1e1e2e";
          urgent-color = "#f38ba8";
        };
        shadow = {
          on = _: {};
          color = "#11111b70";
        };
        tab-indicator = {
          active-color = "#cba6f7";
          inactive-color = "#6d10da";
          urgent-color = "#f38ba8";
        };
        insert-hint.color = "#cba6f780";
        gaps = 4;
        struts = {
          left = -1;
          right = -1;
          top = -1;
          bottom = -1;
        };
      };

      screenshot-path = null;
      gestures.hot-corners = {off = _: {};};

      cursor = {
        xcursor-theme = "Bibata-Modern-Classic";
        xcursor-size = 24;
        hide-when-typing = true;
      };

      window-rules = [
        {
          matches = [{app-id = "termfilechooser";}];
          open-floating = true;
        }
        {
          geometry-corner-radius = 18;
          clip-to-geometry = true;
          shadow = {
            on = _: {};
            softness = 30;
            spread = 5;
            color = "#00000080";
            offset = _: {
              props = {
                x = 0;
                y = 4;
              };
            };
          };
        }
      ];

      binds =
        {
          "Mod+H".focus-column-left = _: {};
          "Mod+J".focus-window-down = _: {};
          "Mod+K".focus-window-up = _: {};
          "Mod+L".focus-column-right = _: {};

          "Mod+Ctrl+H".move-column-left = _: {};
          "Mod+Ctrl+J".move-window-down = _: {};
          "Mod+Ctrl+K".move-window-up = _: {};
          "Mod+Ctrl+L".move-column-right = _: {};

          "Mod+Space".toggle-window-floating = _: {};
          "Mod+Q".close-window = _: {};
          "Mod+F".maximize-column = _: {};
          "Mod+Grave".toggle-overview = _: {};
          "Mod+Comma".consume-window-into-column = _: {};
          "Mod+Period".expel-window-from-column = _: {};
          "Mod+Return".spawn = lib.getExe pkgs.myTerminal;

          "Mod+Alt+H".set-column-width = "-10%";
          "Mod+Alt+J".set-window-height = "-10%";
          "Mod+Alt+K".set-window-height = "+10%";
          "Mod+Alt+L".set-column-width = "+10%";

          "Mod+Shift+S".screenshot = _: {};

          "Mod+Slash".show-hotkey-overlay = _: {};
        }
        // (lib.listToAttrs (map (n: {
          name = "Mod+${toString n}";
          value."focus-workspace" = n;
        }) (lib.range 1 9)))
        // (lib.listToAttrs (map (n: {
          name = "Mod+Shift+${toString n}";
          value."move-column-to-workspace" = n;
        }) (lib.range 1 9)))
        // lib.optionalAttrs config.modules.system.programs.noctalia.enable {
          "Mod+D".spawn-sh = "${lib.getExe pkgs.myNoctalia} msg panel-toggle launcher";
          "Mod+V".spawn-sh = "${lib.getExe pkgs.myNoctalia} msg panel-toggle clipboard";
        };
    }
    // lib.optionalAttrs config.modules.system.programs.noctalia.enable {
      spawn-at-startup = [(lib.getExe pkgs.myNoctalia)];
    }
    // lib.optionalAttrs (config.modules.device.gpu.intel.enable && config.modules.device.gpu.nvidia.enable) {
      debug = {
        render-drm-device = "/dev/dri/by-path/pci-0000:00:02.0-render";
        ignore-drm-device = "/dev/dri/by-path/pci-0000:01:00.0-render";
      };
    };
in {
  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
      useNautilus = false;

      package = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs settings;
      };
    };
  };
}

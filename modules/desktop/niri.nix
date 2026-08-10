{
  mkModuleOption,
  self,
  inputs,
  ...
}: {
  flake-file.inputs.wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

  options.nixos.desktop.niri = mkModuleOption {key = "niri";};

  config.nixos.desktop.niri = {
    pkgs,
    config,
    lib,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri.override {
        hostName = config.networking.hostName;
      };
    };

    environment.systemPackages = [pkgs.nautilus];

    xdg.portal = {
      extraPortals = [pkgs.xdg-desktop-portal-gnome];
      config.niri = {
        default = lib.mkForce ["gnome"];
        "org.freedesktop.impl.portal.FileChooser" = ["gnome"];
        "org.freedesktop.impl.portal.Inhibit" = lib.mkForce ["none"];
      };
    };
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myNiri = pkgs.callPackage ({hostName ? ""}:
      inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings =
          {
            spawn-at-startup = [
              ["${lib.getExe pkgs.swaybg}" "-i" "${./assets/wall1.jpg}"]
            ];

            prefer-no-csd = true;

            animations = {
              workspace-switch.spring = _: {
                props = {
                  damping-ratio = 0.8;
                  stiffness = 500;
                  epsilon = 0.0001;
                };
              };
              window-movement.spring = _: {
                props = {
                  damping-ratio = 0.8;
                  stiffness = 500;
                  epsilon = 0.0001;
                };
              };
              window-resize.spring = _: {
                props = {
                  damping-ratio = 0.8;
                  stiffness = 500;
                  epsilon = 0.0001;
                };
              };
              overview-open-close.spring = _: {
                props = {
                  damping-ratio = 0.8;
                  stiffness = 500;
                  epsilon = 0.0001;
                };
              };
              window-open = {
                duration-ms = 200;
                curve = "ease-out-expo";
              };
              window-close = {
                duration-ms = 150;
                curve = "ease-out-quad";
              };
            };

            input = {
              keyboard.xkb = {
                layout = "us,ru";
                options = "grp:alt_shift_toggle";
              };
              touchpad = {
                tap = _: {};
                natural-scroll = _: {};
              };
            };

            layout = {
              focus-ring = {
                width = 1;
                active-color = "#c6a0f6";
                inactive-color = "#494d64";
              };
              border = {
                width = 1;
                active-color = "#0DB7D455";
                inactive-color = "#31313600";
              };
              shadow = {
                on = _: {};
                softness = 30;
                spread = 3;
                offset = _: {
                  props = {
                    x = 0;
                    y = 4;
                  };
                };
                color = "#181926";
              };
              gaps = 9;
            };

            screenshot-path = null;
            gestures.hot-corners = {off = _: {};};

            cursor = {
              xcursor-theme = "Bibata-Modern-Classic";
              xcursor-size = 24;
              hide-when-typing = true;
            };

            window-rule = {
              clip-to-geometry = true;
              geometry-corner-radius = 12;
            };
            window-rules = [
              {
                matches = [{is-focused = false;}];
                shadow.off = _: {};
              }
            ];

            binds =
              {
                "Mod+Left".focus-column-left = _: {};
                "Mod+Right".focus-column-right = _: {};
                "Mod+Up".focus-window-up = _: {};
                "Mod+Down".focus-window-down = _: {};
                "Mod+Ctrl+Left".move-column-left = _: {};
                "Mod+Ctrl+Right".move-column-right = _: {};
                "Mod+Ctrl+Down".move-window-down = _: {};
                "Mod+Ctrl+Up".move-window-up = _: {};

                "Mod+H".focus-column-left = _: {};
                "Mod+L".focus-column-right = _: {};
                "Mod+J".focus-window-up = _: {};
                "Mod+K".focus-window-down = _: {};
                "Mod+Ctrl+H".move-column-left = _: {};
                "Mod+Ctrl+L".move-column-right = _: {};
                "Mod+Ctrl+J".move-window-down = _: {};
                "Mod+Ctrl+K".move-window-up = _: {};
                "Mod+Space".toggle-window-floating = _: {};
                "Mod+Q".close-window = _: {};
                "Mod+F".maximize-column = _: {};
                "Mod+Grave".toggle-overview = _: {};

                "Mod+Return".spawn = lib.getExe self'.packages.myFoot;
                "Mod+D".spawn = ["${lib.getExe pkgs.rofi}" "-show" "drun"];

                "Mod+Shift+S".screenshot = _: {};
              }
              // (lib.listToAttrs (map (n: {
                name = "Mod+${toString n}";
                value."focus-workspace" = n;
              }) (lib.range 1 9)))
              // (lib.listToAttrs (map (n: {
                name = "Mod+Shift+${toString n}";
                value."move-column-to-workspace" = n;
              }) (lib.range 1 9)));
          }
          // (lib.optionalAttrs (hostName == "victus") {
            debug = {
              render-drm-device = "/dev/dri/by-path/pci-0000:00:02.0-render";
              ignore-drm-device = "/dev/dri/by-path/pci-0000:01:00.0-render";
            };
          });
      }) {};
  };
}

{
  self,
  inputs,
  ...
}: {
  nixos.desktop = {
    pkgs,
    config,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri.override {
        hostName = config.networking.hostName;
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
            prefer-no-csd = true;

            input = {
              keyboard = {
                xkb = {
                  layout = "us,ru";
                  options = "grp:alt_shift_toggle";
                };
                numlock = _: {};
              };
              touchpad = {
                tap = _: {};
                natural-scroll = _: {};
              };
            };

            layout = {
              focus-ring = {
                width = 2.5;
                active-color = "#c6a0f6";
                inactive-color = "#494d64";
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
              border = {off = _: {};};
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

            binds =
              {
                "Mod+Shift+S".screenshot = _: {};

                "Mod+Left".focus-column-left = _: {};
                "Mod+Right".focus-column-right = _: {};
                "Mod+Up".focus-window-up = _: {};
                "Mod+Down".focus-window-down = _: {};

                "Mod+Space".toggle-window-floating = _: {};
                "Mod+Q".close-window = _: {};
                "Mod+F".maximize-column = _: {};
                "Mod+Grave".toggle-overview = _: {};

                "Mod+Ctrl+Left".move-column-left = _: {};
                "Mod+Ctrl+Right".move-column-right = _: {};
                "Mod+Ctrl+Down".move-window-down = _: {};
                "Mod+Ctrl+Up".move-window-up = _: {};

                "Mod+Return".spawn = lib.getExe self'.packages.myFoot;
                "Mod+D".spawn = "${lib.getExe self'.packages.myFuzzel}";
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

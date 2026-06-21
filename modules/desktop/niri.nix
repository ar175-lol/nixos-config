{
  self,
  inputs,
  ...
}: {
  nixos.desktop = {pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
    services.upower.enable = true;
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        prefer-no-csd = true;

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input = {
          keyboard = {
            xkb = {
              layout = "us,ru";
              options = "grp:alt_shift_toggle";
            };
            numlock = _: {};
          };
        };

        layout = {
          focus-ring = {
            width = 4;
            active-color = "#fe8019";
            inactive-color = "#504945";
          };
          border = {off = _: {};};
          gaps = 5;
        };

        gestures = {
          hot-corners = {
            off = _: {};
          };
        };

        cursor = {
          xcursor-theme = "Bibata-Modern-Classic";
          xcursor-size = 24;
          hide-when-typing = true;
        };

        binds =
          {
            "Mod+Shift+S".spawn-sh = lib.getExe (pkgs.writeShellApplication {
              name = "screenshot-tool";
              text = ''
                ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -w 0)" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}
              '';
            });
            "Mod+Q".close-window = _: {};
            "Mod+F".maximize-column = _: {};
            "Mod+Left".focus-column-left = _: {};
            "Mod+Right".focus-column-right = _: {};
            "Mod+Up".focus-window-up = _: {};
            "Mod+Down".focus-window-down = _: {};
            "Mod+Space".toggle-window-floating = _: {};
            "Mod+Slash".toggle-overview = _: {};
            "Mod+Return".spawn-sh = lib.getExe self'.packages.myKitty;
            "Mod+D".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
            "Mod+V".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher clipboard";
          }
          // (lib.listToAttrs (map (n: {
            name = "Mod+${toString n}";
            value."focus-workspace" = n;
          }) (lib.range 1 9)))
          // (lib.listToAttrs (map (n: {
            name = "Mod+Shift+${toString n}";
            value."move-column-to-workspace" = n;
          }) (lib.range 1 9)));
      };
    };
  };
}

{lib, ...}: {
  nixos.desktop = {
    config,
    pkgs,
    ...
  }:
    lib.mkIf config.programs.niri.enable {
      console.useXkbConfig = true;

      services = {
        xserver = {
          enable = true;
          displayManager.lightdm.enable = true;
          excludePackages = [pkgs.xterm];
          xkb = {
            layout = "us,ru";
            options = "grp:alt_shift_toggle";
          };
        };

        displayManager = {
          autoLogin = {
            enable = true;
            user = "ar175";
          };
        };
      };
    };
}

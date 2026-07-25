_: {
  nixos.desktop = {pkgs, ...}: {
    console.useXkbConfig = false;

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
    };
  };
}

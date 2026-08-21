_: {
  users.ar175.nixos.pc = {pkgs, ...}: {
    console.useXkbConfig = false;

    # stylix.targets.lightdm.enable = false;

    services.xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      excludePackages = [pkgs.xterm];
      xkb = {
        layout = "us,ru";
        options = "grp:alt_shift_toggle";
      };
    };
  };
}

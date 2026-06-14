{...}: {
  flake.nixosModules.xserverConfiguration = {pkgs, ...}: {
    services.xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      excludePackages = [pkgs.xterm];
      xkb = {
        layout = "us,ru";
        options = "grp:alt_shift_toggle";
      };
    };
    services.displayManager = {
      autoLogin = {
        enable = true;
        user = "ar175";
      };
    };

    console.useXkbConfig = true;
  };
}

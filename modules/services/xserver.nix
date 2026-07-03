_: {
  nixos.desktop = {pkgs, ...}: {
    services.xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      xkb = {
        layout = "us,ru";
        options = "grp:alt_shift_toggle";
      };
    };

    console.useXkbConfig = true;
  };
}

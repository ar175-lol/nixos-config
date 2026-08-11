_: {
  nixos.base = {pkgs, ...}: {
    boot = {
      kernelParams = [
        "quiet"
        "splash"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];

      kernelPackages = pkgs.linuxPackages_xanmod_latest;
    };
  };
}

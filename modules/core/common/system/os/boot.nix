{pkgs, ...}: {
  boot = {
    loader.efi.canTouchEfiVariables = true;

    # I hate core dumps
    kernel.sysctl."kernel.core_pattern" = "/dev/null";

    tmp.cleanOnBoot = true;
    plymouth.enable = true;
    consoleLogLevel = 0;

    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };
}

_: {
  nixos.base = {pkgs, ...}: {
    boot = {
      kernelParams = [
        "quiet"
        "splash"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "boot.shell_on_fail"
        "nvidia-drm.modeset=1"
      ];

      kernelPackages = pkgs.linuxPackages_xanmod_latest;
    };
    # services.scx = {
    #   enable = true;
    #   scheduler = "scx_bpfland";
    #   extraArgs = ["-m" "auto"];
    # };
  };
}

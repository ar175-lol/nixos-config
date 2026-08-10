_: {
  nixos.base = {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = false;
      };
      kernel.sysctl."kernel.core_pattern" = "/dev/null";

      tmp.cleanOnBoot = true;
      initrd.verbose = false;
      plymouth.enable = true;
      consoleLogLevel = 0;
    };
  };
}

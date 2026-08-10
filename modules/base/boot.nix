_: {
  nixos.base = {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        # timeout = 0;
        systemd-boot.enable = false;

        # limine = {
        #   enable = true;
        #   efiSupport = true;
        #   maxGenerations = 5;
        # };
      };
      kernel.sysctl = {
        "kernel.core_pattern" = "/dev/null";
      };

      tmp.cleanOnBoot = true;

      initrd.verbose = false;
      plymouth.enable = true;
      consoleLogLevel = 0;
    };
  };
}

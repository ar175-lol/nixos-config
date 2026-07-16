_: {
  nixos.base = {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        timeout = 0;

        systemd-boot = {
          enable = true;
          consoleMode = "auto";
          configurationLimit = 5;
        };
      };

      tmp = {
        cleanOnBoot = true;
        # useTmpFs = false;
      };

      initrd.verbose = false;
      plymouth.enable = true;
      consoleLogLevel = 0;
    };
  };
}

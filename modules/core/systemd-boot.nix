_: {
  flake.nixosModules.systemdBootConfiguration = {...}: {
    boot = {
      bootspec.enable = true;
      tmp.cleanOnBoot = true;

      loader = {
        efi.canTouchEfiVariables = true;
        timeout = 0;

        systemd-boot = {
          enable = true;
          consoleMode = "auto";
          configurationLimit = 5;
        };
      };
    };
  };
}

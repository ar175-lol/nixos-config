{mkModuleOption, ...}: {
  options.nixos.boot.grub = mkModuleOption {key = "grub";};

  config.nixos.boot.grub = {
    boot.loader = {
      timeout = 5;

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
  };
}

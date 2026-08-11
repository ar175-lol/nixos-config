{mkModuleOption, ...}: {
  options.nixos.boot.limine = mkModuleOption {key = "limine";};

  config.nixos.boot.limine = {
    boot.loader = {
      limine = {
        enable = true;
        efiSupport = true;
        maxGenerations = 5;
      };

      timeout = 0;
    };
  };
}

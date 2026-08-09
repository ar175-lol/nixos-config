{mkModuleOption, ...}: {
  options.nixos.modules.bluetooth = mkModuleOption {key = "bluetooth";};

  config.nixos.modules.bluetooth = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
          KernelExperimental = true;
        };
        Policy.AutoEnable = true;
      };
    };
  };
}

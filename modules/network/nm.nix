{mkModuleOption, ...}: {
  options.nixos.network.nm = mkModuleOption {key = "nm";};

  config.nixos.network.nm = {
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = "none";
  };
}

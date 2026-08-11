{mkModuleOption, ...}: {
  options.nixos.network.firewall = mkModuleOption {key = "firewall";};

  config.nixos.network.firewall = {
    networking = {
      nftables.enable = true;
      firewall.enable = true;
    };
  };
}

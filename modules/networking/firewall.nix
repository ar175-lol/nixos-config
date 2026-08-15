_: {
  nixos.modules.base = {
    networking = {
      nftables.enable = true;
      firewall.enable = true;
    };
  };
}

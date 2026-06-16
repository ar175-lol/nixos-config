_: {
  nixos.base = {...}: {
    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [53317 11000];
        allowedUDPPorts = [53317 11000];
      };
      nftables.enable = true;
    };
  };
}

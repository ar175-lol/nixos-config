_: {
  nixos.modules.base = {lib, ...}: {
    networking = {
      nftables.enable = true;
      firewall =
        {
          enable = true;
        }
        // lib.genAttrs ["allowedTCPPorts" "allowedUDPPorts"] (_: [53317]);
    };
  };
}

_: {
  nixos.base = {...}: {
    networking = {
      networkmanager.enable = false;

      wireless.iwd = {
        enable = true;
        settings = {
          Network = {
            EnableIPv6 = false;
            NameResolvingService = "none";
          };
          Settings = {
            AutoConnect = true;
          };
        };
      };
    };
  };
}

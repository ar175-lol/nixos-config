{lib, ...}: {
  nixos.modules.base = _: {
    networking = {
      wireless.iwd = {
        enable = true;
        settings = {
          Network = {
            EnableIPv6 = false;
            NameResolvingService = "none";
          };
          General = {
            EnableNetworkConfiguration = true;
            AddressRandomization = "network";
            AddressRandomizationRange = "full";
            ManagementFrameProtection = "1";
            ControlPortOverNL80211 = true;
            DisableANQP = true;
          };
          Rank = {
            BandModifier2_4GHz = 0.5;
            BandModifier5GHz = 1.5;
          };
          Settings.AutoConnect = true;
        };
      };
      dhcpcd.enable = lib.mkDefault false;
      networkmanager.enable = false;
    };
  };
}

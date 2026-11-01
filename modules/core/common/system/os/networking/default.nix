{
  config,
  lib,
  ...
}: let
  device = config.modules.device;
in {
  config = lib.mkMerge [
    (lib.mkIf device.hasWifi {
      networking.wireless.iwd = {
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
            Country = "KZ"; # Without adding this, you will not get 5GHz WiFI
          };
          Rank = {
            BandModifier2_4GHz = 0.5;
            BandModifier5GHz = 1.5;
          };
          Settings.AutoConnect = true;
        };
      };
    })

    {
      networking = {
        dhcpcd = {
          enable = lib.mkDefault device.hasEthernet;
          # Normal priority: netbird always defines this list, even when
          # disabled, so mkDefault would lose and let dhcpcd race iwd.
          denyInterfaces = lib.optionals (device.hasWifi && device.hasEthernet) ["wlan*"];
        };
        networkmanager.enable = false;
      };
    }
  ];
}

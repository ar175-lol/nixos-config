_: {
  nixos.base = {
    services = {
      resolved.enable = false;
      dnscrypt-proxy = {
        enable = true;

        settings = {
          sources.public-resolvers = {
            urls = ["https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"];
            cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
            minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
            refresh_delay = 72;
          };
          require_dnssec = true;
          require_nolog = true;
          require_nofilter = false;

          ipv6_servers = false;
          block_ipv6 = true;

          server_names = ["quad9-dnscrypt-ip4-filter-pri"];
        };
      };
    };

    networking = {
      nameservers = ["127.0.0.1"];
      resolvconf.enable = false;
      nftables.enable = true;
      firewall.enable = true;

      networkmanager.enable = false;
      dhcpcd.enable = false;

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
        };
      };
    };
  };
}

_: {
  flake.nixosModules.dnscryptConfiguration = {...}: {
    services.resolved.enable = false;
    services.dnscrypt-proxy = {
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
    networking = {
      nameservers = ["127.0.0.1"];
      resolvconf.enable = false;
    };
  };
}

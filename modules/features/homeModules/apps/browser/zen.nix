{...}: {
  flake.homeModules.myZen = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      policies = (import ./_policies.nix) {};

      profiles.default = {
        isDefault = true;
        pinsForce = true;
        pinsForceAction = "remove";

        mods = [
          "7190e4e9-bead-4b40-8f57-95d852ddc941"
        ];

        pins = {
          "YouTube" = {
            id = "f27109b8-3514-458c-b724-df95b439a42b";
            url = "https://www.youtube.com";
            position = 1;
            isEssential = true;
          };
          "Gemini" = {
            id = "09d13387-b5cc-4188-ac16-046041387c40";
            url = "https://gemini.google.com";
            position = 2;
            isEssential = true;
          };
          "Proton Mail" = {
            id = "711ff732-f2c4-451d-961b-ba06dc68094e";
            url = "https://mail.proton.me/u/0/inbox";
            position = 3;
            isEssential = true;
          };
          "GitHub" = {
            id = "7d8dbcdc-f0a5-4932-a9ff-cc53f346ad57";
            url = "https://github.com";
            position = 4;
            isEssential = true;
          };
        };

        search = {
          force = true;
          default = "google";
          engines = {
            mynixos = {
              name = "My NixOS";
              urls = [
                {
                  template = "https://mynixos.com/search?q={searchTerms}";
                  params = [
                    {
                      name = "query";
                      value = "searchTerms";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@nx"];
            };
            archwiki = {
              name = "Arch Wiki";
              urls = [
                {
                  template = "https://wiki.archlinux.org/title/Special:Search/%s";
                }
              ];
              definedAliases = ["@aw"];
            };
          };
        };
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.discovery.enabled" = false;
          "general.smoothScroll" = true;
          "network.predictor.enable-prefetch" = false;
          "network.dns.disableIPv6" = true;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "network.http.referer.trimmingPolicy" = 2;
          "app.normandy.enabled" = false;
          "app.normandy.first_run" = false;
          "geo.enabled" = false;
          "media.peerconnection.enabled" = false;
          "privacy.resistFingerprinting.testGranularityMask" = 4;
        };
      };
    };
  };
}

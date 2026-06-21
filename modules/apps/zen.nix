_: {
  nixos.home = {
    inputs,
    pkgs,
    ...
  }: let
    mkLockedAttrs = builtins.mapAttrs (_: value: {
      Value = value;
      Status = "locked";
    });
  in {
    imports = [inputs.zen-browser.homeModules.beta];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DontCheckDefaultBrowser = true;

        UserMessaging = {
          Locked = true;
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = false;
          MoreFromMozilla = false;
          FirefoxLabs = false;
        };

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
          Category = "strict";
        };

        SanitizeOnShutdown = {
          Locked = true;
          Cache = true;
          History = true;
          FormData = true;
          Cookies = false;
          Sessions = false;
          SiteSettings = false;
        };

        Preferences = mkLockedAttrs {
          "gfx.webrender.all" = true;
          "media.hardware-video-decoding.enabled" = true;
          "media.hardware-video-decoding.force-enabled" = true;
          "media.navigator.mediadatadecoder_vpx_enabled" = true;
          "media.ffvpx.enabled" = false;
          "media.ffmpeg.vaapi.enabled" = true;
          "network.http.max-persistent-connections-per-proxy" = 256;
          "network.http.max-persistent-connections-per-server" = 12;
          "network.dns.disableIPv6" = true;
          "network.http.max-connections" = 1500;

          "zen.view.compact.enable-at-startup" = true;
          "general.smoothScroll" = true;
          "browser.discovery.enabled" = false;
        };

        Proxy = {
          Mode = "manual";
          Locked = true;
          SOCKSProxy = "127.0.0.1:40000";
          SOCKSVersion = 5;
          UseProxyForDNS = true;
          Passthrough = "<local>";
        };

        FirefoxHome = {
          Search = false;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          Stories = false;
          SponsoredStories = false;
          Snippets = false;
        };

        AIControls = {
          Default = {
            Value = "blocked";
            Locked = true;
          };
        };

        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };
          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "force_installed";
          };
          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            installation_mode = "force_installed";
          };
          "ru@dictionaries.addons.mozilla.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4270210/russian_spellchecking_dic_3703-0.4.5.2resigned1.xpi";
            installation_mode = "force_installed";
          };
        };
      };

      profiles.default = {
        isDefault = true;
        pinsForce = true;
        pinsForceAction = "remove";

        mods = [
          "7190e4e9-bead-4b40-8f57-95d852ddc941"
          "a6335949-4465-4b71-926c-4a52d34bc9c0"
          "f7c71d9a-bce2-420f-ae44-a64bd92975ab"
          "d8b79d4a-6cba-4495-9ff6-d6d30b0e94fe"
        ];

        pins = {
          "YouTube" = {
            id = "f27109b8-3514-458c-b724-df95b439a42b";
            url = "https://www.youtube.com";
            position = 1;
            isEssential = true;
          };
          "Claude" = {
            id = "09d13387-b5cc-4188-ac16-046041387c40";
            url = "https://claude.ai/new";
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
                  params = [
                    {
                      name = "query";
                      value = "searchTerms";
                    }
                  ];
                }
              ];
              definedAliases = ["@aw"];
            };
          };
        };

        settings = {
          "browser.aboutConfig.showWarning" = false;
          "network.predictor.enable-prefetch" = false;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "network.http.referer.trimmingPolicy" = 2;
          "app.normandy.enabled" = false;
          "app.normandy.first_run" = false;
          "geo.enabled" = false;
          "media.peerconnection.enabled" = false;
          "privacy.donottrackheader.enabled" = true;
          "dom.deviceMemory" = 8;
          "dom.battery.enabled" = false;
          "dom.webdriver.enabled" = false;
          "dom.maxHardwareConcurrency" = 4;
          "privacy.resistFingerprinting.testGranularityMask" = 4;
          "privacy.resistFingerprinting.letterboxing" = false;
        };
      };
    };
  };
}

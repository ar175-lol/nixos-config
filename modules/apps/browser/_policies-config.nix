let
  mkLockedAttrs = builtins.mapAttrs (_: value: {
    Value = value;
    Status = "locked";
  });
in {
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
    "browser.discovery.enabled" = false;
    "general.autoScroll" = true;
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
}

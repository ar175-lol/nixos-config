_: {
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

  AIControls = {
    Default = {
      Value = "blocked";
      Locked = true;
    };
  };

  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
    EmailTracking = true;
    Category = "strict";
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
    TopSites = true;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    Stories = false;
    SponsoredStories = false;
    Snippets = false;
  };

  Preferences = {
    "gfx.webrender.all" = true;
    "zen.view.compact.enable-at-startup" = true;
    "media.ffmpeg.vaapi.enabled" = true;
    "network.http.max-connections" = 1500;
    "network.http.max-persistent-connections-per-proxy" = 256;
    "network.http.max-persistent-connections-per-server" = 12;
  };

  SanitizeOnShutdown = {
    Locked = true;
    Cache = true;
    Cookies = false;
    History = true;
    FormData = true;
    SiteSettings = false;
    Sessions = false;
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

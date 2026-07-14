let
  mkLockedAttrs = builtins.mapAttrs (_: value: {
    Value = value;
    Status = "locked";
  });
  mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
    installation_mode = "force_installed";
  });
in {
  Preferences = mkLockedAttrs {
    "gfx.webrender.all" = true;
    "accessibility.force_disabled" = 1;
    "network.dns.disablePrefetch" = true;
    "network.prefetch-next" = false;
    "browser.cache.memory.capacity" = -1;
    "general.autoScroll" = true;
    "network.http.max-persistent-connections-per-proxy" = 48;
    "network.http.max-urgent-start-excessive-connections-per-host" = 6;
    "network.http.pacing.requests.min-parallelism" = 18;
    "browser.aboutConfig.showWarning" = false;
    "browser.tabs.warnOnClose" = false;
    "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
    "browser.gesture.swipe.left" = "";
    "browser.gesture.swipe.right" = "";
    "browser.tabs.hoverPreview.enabled" = true;
    "privacy.spoof_english" = 1;
  };

  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Category = "strict";
    Cryptomining = true;
    Fingerprinting = true;
    SuspectedFingerprinting = true;
    EmailTracking = true;
    BaselineExceptions = true;
    ConvenienceExceptions = true;
  };

  SanitizeOnShutdown = {
    Locked = true;
    FormData = true;
    Cache = true;
    History = true;
    Sessions = false;
  };

  AIControls = {
    Default = {
      Value = "blocked";
      Locked = true;
    };
  };

  ExtensionSettings = mkExtensionSettings {
    "uBlock0@raymondhill.net" = "ublock-origin";
    "sponsorBlocker@ajay.app" = "sponsorblock";
  };

  UserMessaging = {
    ExtensionRecommendations = false;
    FeatureRecommendations = false;
    UrlbarInterventions = false;
    SkipOnboarding = true;
    MoreFromMozilla = false;
    FirefoxLabs = false;
    Locked = true;
  };

  DNSOverHTTPS = {
    Enabled = false;
    Locked = true;
  };

  PopupBlocking = {
    Default = true;
    Locked = true;
  };

  GenerativeAI = {
    Enabled = false;
    Locked = true;
  };

  RequestedLocales = [
    "en-US"
  ];

  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;
  BackgroundAppUpdate = false;
  DisableAccounts = true;
  DisableSetDesktopBackground = true;
  DownloadDirectory = "/home/ar175/Downloads";
  DisableAppUpdate = true;
  DisableFeedbackCommands = true;
  DisableFirefoxStudies = true;
  DontCheckDefaultBrowser = true;
  HardwareAcceleration = true;
  IPProtectionAvailable = false;
  PrintingEnabled = false;
}

let
  mkLockedAttrs = builtins.mapAttrs (_: value: {
    Value = value;
    Status = "locked";
  });
in {
  Preferences = mkLockedAttrs {
    "gfx.webrender.all" = true;
    "accessibility.force_disabled" = 1;
    "browser.aboutConfig.showWarning" = false;
    "browser.tabs.warnOnClose" = false;
    "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
    "browser.gesture.swipe.left" = "";
    "browser.gesture.swipe.right" = "";
    "browser.tabs.hoverPreview.enabled" = true;
    "privacy.spoof_english" = 1;

    "general.autoScroll" = true;
    "general.smoothScroll.msdPhysics.enabled" = true;
    "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
    "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
    "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
    "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
    "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
    "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2;
    "general.smoothScroll.currentVelocityWeighting" = "1";
    "general.smoothScroll.stopDecelerationWeighting" = "1";
    "mousewheel.default.delta_multiplier_y" = 300;

    "media.cache_readahead_limit" = 3600;
    "media.cache_resume_threshold" = 1800;

    "browser.tabs.unloadOnLowMemory" = true;
    "browser.low_commit_space_threshold_mb" = 2024;

    "gfx.canvas.accelerated.cache-size" = 512;

    "browser.cache.disk.enable" = false;
    "browser.cache.memory.capacity" = 32768;
    "browser.cache.memory.max_entry_size" = 1024;

    "network.http.max-connections" = 1800;
    "network.http.max-persistent-connections-per-server" = 10;
    "network.http.max-persistent-connections-per-proxy" = 48;
    "network.http.max-urgent-start-excessive-connections-per-host" = 6;
    "network.http.pacing.requests.min-parallelism" = 18;
    "network.dns.disablePrefetch" = true;
    "network.prefetch-next" = false;

    "security.OCSP.enabled" = 0;
    "browser.privatebrowsing.forceMediaMemoryCache" = true;
    "media.memory_cache_max_size" = 65536;

    "browser.sessionstore.interval" = 300000;
    "privacy.antitracking.isolateContentScriptResources" = true;
    "security.csp.reporting.enabled" = false;
    "security.ssl.treat_unsafe_negotiation_as_broken" = true;
    "security.tls.enable_0rtt_data" = false;
    "browser.xul.error_pages.expert_bad_cert" = true;
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

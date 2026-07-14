{inputs, ...}: {
  nixos.victus = {
    imports = [inputs.helium.nixosModules.default];

    programs.helium = {
      enable = true;

      flags = [
        "--password-store=basic"
        "--ozone-platform-hint=auto"
        "--enable-features=TouchpadOverscrollHistoryNavigation,CanvasOopRasterization"
        "--js-flags=--max-semi-space-size=2 --expose-gc"
        "--disable-reading-from-canvas"
        "--enable-gpu-rasterization"
        "--process-per-site"
      ];

      policies = {
        "PasswordManagerEnabled" = false;
        "BuiltInAIAPIsEnabled" = false;
        "MetricsReportingEnabled" = false;
        "SearchSuggestEnabled" = false;
        "AlternateErrorPagesEnabled" = false;
        "SafeBrowsingProtectionLevel" = 0;

        "HighEfficiencyModeEnabled" = true;
        "MemorySaverModeSavings" = 2;
        "DiskCacheSize" = 268435456;
        "HardwareAccelerationModeEnabled" = true;

        "BlockThirdPartyCookies" = true;
        "BackgroundModeEnabled" = false;
        "ComponentUpdatesEnabled" = false;
        "NetworkPredictionOptions" = 2;
      };
    };
  };
}

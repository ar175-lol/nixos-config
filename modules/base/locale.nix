{mkModuleOption, ...}: {
  options.nixos.locale = {
    victus = mkModuleOption {key = "locale-victus";};
    dkirk = mkModuleOption {key = "locale-dkirk";};
  };

  config.nixos.locale = {
    ar175 = {lib, ...}: {
      time.timeZone = "Asia/Almaty";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = lib.genAttrs ["LC_MEASUREMENT" "LC_NUMERIC" "LC_PAPER" "LC_TIME"] (_: "en_GB.UTF-8");
    };
    kirk = {
      time.timeZone = "Europe/Moscow";
      i18n.defaultLocale = "ru_RU.UTF-8";
    };
  };
}

_: {
  nixos.base = {lib, ...}: {
    time.timeZone = "Asia/Almaty";
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings =
      lib.genAttrs
      [
        "LC_MEASUREMENT"
        "LC_NUMERIC"
        "LC_PAPER"
        "LC_TIME"
      ]
      (_: "en_GB.UTF-8");
  };
}

_: {
  users.ar175.nixos.pc = {
    time.timeZone = "Asia/Almaty";
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
      };
    };
  };
}

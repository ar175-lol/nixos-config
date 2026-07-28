_: {
  homeManager.ar175 = {
    programs.firefox = {
      enable = true;

      profiles = {
        "dev-edition-default" = {
          id = 2;

          settings = {
            "browser.aboutConfig.showWarning" = false;
          };
        };
        "test-2" = {
          settings = {
            "browser.startup.homepage" = "https://nixos.org";
            "browser.search.region" = "GB";
            "browser.search.isUS" = false;
            "distribution.searchplugins.defaultLocale" = "en-GB";
            "general.useragent.locale" = "en-GB";
            "browser.bookmarks.showMobileBookmarks" = true;
          };
        };
      };
    };
  };
}

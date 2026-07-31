_: {
  homeManager.ar175 = {config, ...}: {
    home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "/home/ar175/nixos-config/modules/desktop/rofi";

    xdg.desktopEntries = {
      rofi = {
        name = "Rofi";
        noDisplay = true;
      };
      "rofi-theme-selector" = {
        name = "Rofi Theme Selector";
        noDisplay = true;
      };
    };
  };
}

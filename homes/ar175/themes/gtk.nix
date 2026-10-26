{
  pkgs,
  inputs,
  ...
}: let
  catppuccinGtkTheme = pkgs.catppuccin-gtk.override {
    accents = ["mauve"];
    size = "standard";
    variant = "mocha";
  };
  themeName = "catppuccin-mocha-mauve-standard";
in {
  imports = [inputs.catppuccin.homeModules.catppuccin];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";
    gtk.icon.enable = true;
    kvantum.enable = false;
  };

  gtk = {
    enable = true;
    theme = {
      name = themeName;
      package = catppuccinGtkTheme;
    };

    gtk4.theme = {
      name = themeName;
      package = catppuccinGtkTheme;
    };

    font = {
      package = null;
      name = "JetBrainsMono Nerd Font 11";
    };
  };

  home.pointerCursor = {
    enable = true;
    name = "oreo_spark_pink_bordered_cursors";
    package = pkgs.oreo-cursors-plus;
    size = 30;
    gtk.enable = true;
    x11.enable = true;
  };
}

{pkgs, ...}: let
  catppuccinGtkTheme = pkgs.catppuccin-gtk.override {
    accents = ["mauve"];
    size = "standard";
    variant = "mocha";
  };
  themeName = "catppuccin-mocha-mauve-standard";
in {
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
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "Monocraft";
      size = 11;
    };
  };

  home.pointerCursor = {
    enable = true;
    name = "oreo_spark_purple_bordered_cursors";
    package = pkgs.oreo-cursors-plus;
    size = 30;
    gtk.enable = true;
    x11.enable = true;
  };
}

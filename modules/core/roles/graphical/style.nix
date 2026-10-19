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

  home = {
    imports = [inputs.catppuccin.homeModules.catppuccin];

    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "mocha";
      accent = "mauve";
      gtk.icon.enable = true;
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
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };
in {
  config.home-manager.sharedModules = [home];
}

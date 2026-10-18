{
  lib,
  pkgs,
  inputs,
  config,
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
  # Look and feel is part of the session: no option, a graphical host simply
  # looks like this.
  config.home-manager.users = builtins.listToAttrs (map (name: lib.nameValuePair name home) config.myUsers.homes);
}

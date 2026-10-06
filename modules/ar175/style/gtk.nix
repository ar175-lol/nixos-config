{
  flake-file.inputs.catppuccin.url = "github:catppuccin/nix";
  users.ar175.home.gui = {
    inputs,
    pkgs,
    ...
  }: let
    catppuccinGtkTheme = pkgs.catppuccin-gtk.override {
      accents = [
        "mauve"
      ];
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
  };
}

{
  flake-file.inputs.catppuccin.url = "github:catppuccin/nix";
  users.ar175.home.gui = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.catppuccin.homeModules.catppuccin];

    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "mocha";
      accent = "mauve";
      gtk.icon.enable = true;
    };

    # dconf.settings."org/gnome/desktop/interface" = {
    #   color-scheme = "prefer-dark";
    #   font-name = "JetBrainsMono Nerd Font 11";
    # };

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Standard-Mauve-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["mauve"];
          size = "standard";
          variant = "mocha";
        };
      };
      font = {
        package = null;
        name = "JetBrainsMono Nerd Font 11";
      };
    };
  };
}

_: {
  homeManager.ar175 = {pkgs, ...}: let
    tokyoNightIcons = pkgs.stdenv.mkDerivation {
      pname = "tokyo-night-icons";
      version = "0.2.0";

      src = pkgs.fetchurl {
        url = "https://github.com/ljmill/tokyo-night-icons/releases/download/v0.2.0/TokyoNight-SE.tar.bz2";
        hash = "sha256-s6aqdswMj8Vk7dlTD6gZAq3OlM1PrDodjvhAqsYRlqo=";
      };

      dontFixup = true;
      nativeBuildInputs = [pkgs.bzip2];
      sourceRoot = ".";

      installPhase = ''
        mkdir -p $out/share/icons
        cp -r TokyoNight-SE $out/share/icons/
      '';
    };
  in {
    home.sessionVariables = {
      GTK_THEME = "adw-gtk3-dark";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "adw-gtk3-dark";
        icon-theme = "TokyoNight-SE";
      };
    };

    gtk = {
      enable = true;

      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };

      iconTheme = {
        name = "TokyoNight-SE";
        package = tokyoNightIcons;
      };

      gtk2.extraConfig = ''
        gtk-application-prefer-dark-theme = 1
      '';

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    xdg.configFile."gtk-4.0/gtk.css".text = ''
      @define-color accent_color #82aaff;
      @define-color accent_bg_color #82aaff;
      @define-color accent_fg_color #1b1d2b;

      @define-color window_bg_color #222436;
      @define-color window_fg_color #c8d3f5;

      @define-color view_bg_color #1e2030;
      @define-color view_fg_color #c8d3f5;

      @define-color headerbar_bg_color #1b1d2b;
      @define-color headerbar_fg_color #c8d3f5;
      @define-color headerbar_border_color #2d3f76;
      @define-color headerbar_backdrop_color #1b1d2b;

      @define-color sidebar_bg_color #1b1d2b;
      @define-color sidebar_fg_color #c8d3f5;

      @define-color card_bg_color #2f334d;
      @define-color card_fg_color #c8d3f5;
      @define-color dialog_bg_color #222436;
      @define-color popover_bg_color #2f334d;
    '';
  };
}

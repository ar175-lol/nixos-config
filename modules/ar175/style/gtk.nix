{
  users.ar175.nixos.pc = {pkgs, ...}: let
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
    environment.systemPackages = [tokyoNightIcons];
  };

  users.ar175.home.gui = {
    pkgs,
    ...
  }: {
    home.sessionVariables.GTK_THEME = "adw-gtk3-dark";

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    gtk.iconTheme = {
      package = null;
      name = "TokyoNight-SE";
    };

    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
    };
  };
}

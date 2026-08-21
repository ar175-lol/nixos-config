{inputs, ...}: {
  flake-file.inputs.stylix.url = "github:danth/stylix";

  users.ar175.nixos.pc = {pkgs, ...}: let
    inherit (inputs) stylix;

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
    imports = [stylix.nixosModules.stylix];

    stylix = {
      enable = true;
      polarity = "dark";
      image = ../assets/wall1.jpg;

      cursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;
      };

      icons = {
        enable = true;
        package = tokyoNightIcons;
        light = "TokyoNight-SE";
        dark = "TokyoNight-SE";
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        sizes = {
          applications = 10;
          desktop = 10;
          popups = 10;
        };
      };
    };
  };
}

{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.libreoffice;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.libreoffice-stable
      pkgs.simple-scan
    ];
    fonts.packages = [
      pkgs.corefonts
      pkgs.dejavu_fonts
    ];
  };
}

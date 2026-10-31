{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system.fonts;
in {
  config = {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
      };
      packages = [pkgs.nerd-fonts.jetbrains-mono pkgs.monocraft];
    };

    fonts.enableDefaultPackages = lib.mkIf cfg.enable true;
  };
}

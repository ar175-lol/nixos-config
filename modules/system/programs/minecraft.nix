{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.minecraft;

  home = {
    programs.prismlauncher = {
      enable = true;
      package = inputs.prism-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
in {
  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [home];
  };
}

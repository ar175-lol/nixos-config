{
  inputs,
  pkgs,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.modules.profiles.gaming.minecraft;
in {
  config = lib.mkIf cfg.enable {
    programs.prismlauncher = {
      enable = true;
      package = inputs.prism-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}

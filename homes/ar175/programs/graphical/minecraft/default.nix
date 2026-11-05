{
  inputs,
  pkgs,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.modules.system.programs.prismlauncher;
in {
  config = lib.mkIf cfg.enable {
    programs.prismlauncher = {
      enable = true;
      package = inputs.prism-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}

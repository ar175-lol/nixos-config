{
  lib,
  pkgs,
  inputs,
  osConfig,
  ...
}: let
  cfg = osConfig.modules.system.programs.pwsp;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [inputs.pwsp.packages.${pkgs.stdenv.hostPlatform.system}.default];
  };
}

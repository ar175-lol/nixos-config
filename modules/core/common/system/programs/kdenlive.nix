{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.kdenlive;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.kdePackages.kdenlive];
  };
}

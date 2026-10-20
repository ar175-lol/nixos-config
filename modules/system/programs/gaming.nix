{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.gaming;
in {
  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;

    environment.systemPackages = [
      pkgs.qbittorrent
      pkgs.bottles
    ];
  };
}

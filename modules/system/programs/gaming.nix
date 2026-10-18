{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.gaming;
in {
  # Steam plus the launchers and tools that keep it company.
  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;

    environment.systemPackages = [
      pkgs.qbittorrent
      pkgs.bottles
    ];
  };
}

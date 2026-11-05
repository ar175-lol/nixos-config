{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.modules.system.programs;
in {
  home.packages = lib.mkMerge [
    (lib.mkIf cfg.bottles.enable [pkgs.bottles])
    (lib.mkIf cfg.qbittorrent.enable [pkgs.qbittorrent])
  ];
}

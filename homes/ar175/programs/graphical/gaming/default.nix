{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.modules.profiles.gaming;
in {
  home.packages = lib.mkMerge [
    (lib.mkIf cfg.bottles.enable [pkgs.bottles])
    (lib.mkIf cfg.qbittorrent.enable [pkgs.qbittorrent])
  ];
}

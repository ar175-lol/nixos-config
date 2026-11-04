{
  config,
  lib,
  ...
}: let
  cfg = config.modules.profiles.gaming;
in {
  config = lib.mkIf cfg.enable {
    modules.profiles.gaming = {
      steam.enable = lib.mkDefault true;
      bottles.enable = lib.mkDefault true;
      qbittorrent.enable = lib.mkDefault true;
      minecraft.enable = lib.mkDefault true;
    };
  };
}

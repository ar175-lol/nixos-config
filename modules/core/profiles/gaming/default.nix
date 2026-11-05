{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
  cfg = config.modules.profiles.gaming;
in {
  config = lib.mkIf cfg.enable {
    modules.system.programs = {
      steam.enable = mkDefault true;
      prismlauncher.enable = mkDefault true;
      bottles.enable = mkDefault true;
      qbittorrent.enable = mkDefault true;
    };
  };
}

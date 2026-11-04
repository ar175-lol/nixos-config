{
  lib,
  config,
  ...
}: let
  cfg = config.modules.profiles.gaming.steam;
in {
  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
  };
}

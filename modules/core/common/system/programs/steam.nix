{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.programs.steam;
in {
  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
  };
}

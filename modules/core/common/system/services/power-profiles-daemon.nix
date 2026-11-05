{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.services.power-profiles-daemon;
in {
  config = lib.mkIf cfg.enable {
    services.power-profiles-daemon.enable = true;
  };
}

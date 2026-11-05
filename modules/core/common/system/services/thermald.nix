{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.services.thermald;
in {
  config = lib.mkIf cfg.enable {
    services.thermald.enable = true;
  };
}

{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.powerSave;
in {
  config = lib.mkIf cfg.enable {
    boot.kernelModules = ["msr"];

    services = {
      power-profiles-daemon.enable = true;
      thermald.enable = true;
      undervolt = {
        enable = true;

        p1 = {
          limit = 30;
          window = 28;
        };

        p2 = {
          limit = 45;
          window = 2.4;
        };
      };
    };
  };
}

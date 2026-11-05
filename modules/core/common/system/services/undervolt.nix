{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.services.undervolt;
in {
  config = lib.mkIf cfg.enable {
    boot.kernelModules = ["msr"];

    services.undervolt = {
      enable = true;
      inherit (cfg) p1 p2;
    };
  };
}

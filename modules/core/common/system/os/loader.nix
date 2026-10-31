{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.loader;
in {
  config = lib.mkIf cfg.enable {
    boot = {
      loader = {
        limine = {
          enable = true;
          efiSupport = true;
          maxGenerations = 5;
        };

        timeout = 2;
      };
    };
  };
}

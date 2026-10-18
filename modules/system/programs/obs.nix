{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.programs.obs;
in {
  config = lib.mkIf cfg.enable {
    programs.obs-studio.enable = true;
  };
}

{
  config,
  lib,
  ...
}: let
  cfg = config.modules.profiles.gaming;
in {
  config = lib.mkIf cfg.enable {
    modules.system.programs = {
      gaming.enable = lib.mkDefault true;
    };
  };
}

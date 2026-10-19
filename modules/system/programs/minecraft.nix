{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.programs.minecraft;

  home = {
    programs.prismlauncher.enable = true;
  };
in {
  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [home];
  };
}

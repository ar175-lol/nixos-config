{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.programs.flatpak;
in {
  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}

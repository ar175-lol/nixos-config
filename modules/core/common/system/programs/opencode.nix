{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.opencode;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.opencode];
  };
}

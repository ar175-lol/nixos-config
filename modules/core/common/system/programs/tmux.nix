{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.tmux;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.myTmux];
  };
}

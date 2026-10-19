{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.adb;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.android-tools];
  };
}

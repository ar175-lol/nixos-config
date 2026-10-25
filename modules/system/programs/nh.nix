{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.nh;
in {
  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [
      ({config, ...}: {
        programs.nh = {
          enable = true;
          flake = "${config.home.homeDirectory}/nixos-config";
        };

        home.packages = [
          pkgs.nix-output-monitor
          pkgs.nvd
        ];
      })
    ];
  };
}

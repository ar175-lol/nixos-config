{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.minecraft;

  home = {
    imports = [inputs.prism-launcher.homeModules.default];

    programs.prism-launcher = {
      enable = true;

      offline = {
        enable = true;
        username = cfg.offlineUsername;
      };

      jdks = [
        pkgs.jdk21
        pkgs.jdk17
      ];
    };
  };
in {
  config = lib.mkIf cfg.enable {
    home-manager.users = builtins.listToAttrs (map (name: lib.nameValuePair name home) config.myUsers.homes);
  };
}

{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.direnv;
  home = {
    programs.direnv = {
      enable = true;
      silent = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    home.packages = with pkgs; [devenv];
  };
in {
  config = lib.mkIf cfg.enable {
    home-manager.users = builtins.listToAttrs (map (name: lib.nameValuePair name home) config.myUsers.homes);
  };
}

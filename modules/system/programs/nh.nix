{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.nh;

  home = homeDir: {
    programs.nh = {
      enable = true;
      flake = "${homeDir}/nixos-config";
    };

    home.packages = with pkgs; [
      nix-output-monitor
      nvd
    ];
  };
in {
  config = lib.mkIf cfg.enable {
    home-manager.users = builtins.listToAttrs (
      map (name: lib.nameValuePair name (home config.users.users.${name}.home or "/home/${name}")) config.myUsers.homes
    );
  };
}

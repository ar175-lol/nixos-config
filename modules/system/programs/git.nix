{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.git;
  home = {
    programs.git = {
      enable = true;

      ignores = [
        ".direnv"
        ".devenv"
        "target"
      ];

      settings = {
        user = {
          name = "ar175-lol";
          email = "ghailmbv@proton.me";
          signingkey = "~/.ssh/id_ed25519.pub";
        };
        gpg.format = "ssh";
        commit.gpgsign = true;

        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        core.editor = "zeditor -e -w";
      };
    };

    home.packages = [pkgs.gh];
  };
in {
  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [home];
  };
}

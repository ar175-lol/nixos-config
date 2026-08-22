_: {
  users.ar175.home.base = {pkgs, ...}: {
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
        core.editor = "nvim";
      };
    };
    home.packages = [pkgs.gh];
  };
}

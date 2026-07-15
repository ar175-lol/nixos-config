_: {
  nixos.home = {pkgs, ...}: {
    programs.git = {
      enable = true;
      ignores = [
        ".envrc"
        ".direnv"
        ".pre-commit-config.yaml"
      ];
      settings = {
        user.name = "ar175-lol";
        user.email = "ghailmbv@proton.me";
        gpg.format = "ssh";
        commit.gpgsign = true;
        user.signingkey = "~/.ssh/id_ed25519.pub";
        
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        core.editor = "nvim";
      };
    };
    home.packages = with pkgs; [gh];
  };
}

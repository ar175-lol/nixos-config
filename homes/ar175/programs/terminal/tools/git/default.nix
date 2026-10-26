{pkgs, ...}: {
  programs.git = {
    enable = true;

    ignores = [
      ".direnv"
      ".devenv"
      "target"
    ];

    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
    };
  };

  home.packages = [pkgs.gh];
}

_: {
  nixos.home = _: {
    programs.git = {
      enable = true;
      settings = {
        user.name = "ar175-lol";
        user.email = "ghailmbv@proton.me";
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        core.editor = "nvim";
      };
    };
  };
}

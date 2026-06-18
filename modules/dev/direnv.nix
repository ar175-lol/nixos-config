_: {
  nixos.home = _: {
    programs.direnv = {
      enable = true;
      silent = true;
      enableNixDirenvIntegration = true;
      enableZshIntegration = true;
    };
  };
}

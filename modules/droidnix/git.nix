_: {
  nixOnDroid.modules.base = {
    home-manager.config = {
      programs.git.enable = true;
    };
  };
}
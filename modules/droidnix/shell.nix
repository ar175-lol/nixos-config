_: {
  nixOnDroid.modules.base = {
    home-manager.config = {
      programs.fish.enable = true;
      programs.starship.enable = true;
    };
  };
}
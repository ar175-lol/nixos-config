{lib, ...}: {
  config = {
    programs = {
      fish.enable = true;
      zsh.enable = true;
    };

    modules.system.programs = {
      niri.enable = lib.mkDefault true;
      greeter.enable = lib.mkDefault true;
      noctalia.enable = lib.mkDefault true;
      tmux.enable = lib.mkDefault true;
    };
  };
}

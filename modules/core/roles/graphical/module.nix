{lib, ...}: {
  config.modules.system.programs = {
    niri.enable = lib.mkDefault true;
    greeter.enable = lib.mkDefault true;
    noctalia.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
  };
}

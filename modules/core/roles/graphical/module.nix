{lib, ...}: {
  # The desktop session itself. portal/shell/style/xdg are imported from this
  # directory and act unconditionally: a machine playing this role wants all
  # of them.
  config.modules.system.programs = {
    niri.enable = lib.mkDefault true;
    greeter.enable = lib.mkDefault true;
    noctalia.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
  };
}

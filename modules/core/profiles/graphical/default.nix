{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
  cfg = config.modules.profiles.graphical;
in {
  config = lib.mkIf cfg.enable {
    programs = {
      fish.enable = true;
      zsh.enable = true;
    };

    modules.system.programs = {
      niri.enable = mkDefault true;
      greeter.enable = mkDefault true;
      noctalia.enable = mkDefault true;
      tmux.enable = mkDefault true;
    };
  };
}

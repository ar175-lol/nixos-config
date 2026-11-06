{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
  cfg = config.modules.profiles.workstation;
in {
  config = lib.mkIf cfg.enable {
    modules.profiles.graphical.enable = mkDefault true;

    modules.system = {
      programs = {
        neovim.enable = mkDefault true;
        opencode.enable = mkDefault true;
        localsend.enable = mkDefault true; # i keep forgettng localsend exists lmao
        libreoffice.enable = mkDefault true;
        kdenlive.enable = mkDefault true; # not sure
        printing.enable = mkDefault true;
        virtualisation.enable = mkDefault true;
        adb.enable = mkDefault true;
      };
      doas.enable = mkDefault true;
    };
  };
}

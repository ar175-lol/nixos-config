{
  config,
  lib,
  ...
}: let
  cfg = config.modules.profiles.workstation;
in {
  config = lib.mkIf cfg.enable {
    modules.system.programs = {
      neovim.enable = lib.mkDefault true;
      opencode.enable = lib.mkDefault true;
      localsend.enable = lib.mkDefault true;
      libreoffice.enable = lib.mkDefault true;
      kdenlive.enable = lib.mkDefault true;
    };
  };
}

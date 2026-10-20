{
  config,
  lib,
  ...
}: let
  cfg = config.modules.profiles.workstation;
in {
  config = lib.mkIf cfg.enable {
    modules.system.programs = {
      browser.enable = lib.mkDefault true;
      neovim.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      direnv.enable = lib.mkDefault true;
      nh.enable = lib.mkDefault true;
      opencode.enable = lib.mkDefault true;
      discord.enable = lib.mkDefault true;
      telegram.enable = lib.mkDefault true;
      localsend.enable = lib.mkDefault true;
      libreoffice.enable = lib.mkDefault true;
      obs.enable = lib.mkDefault true;
      kdenlive.enable = lib.mkDefault true;
    };
  };
}

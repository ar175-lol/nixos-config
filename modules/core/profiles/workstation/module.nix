{
  config,
  lib,
  ...
}: let
  cfg = config.modules.profiles.workstation;
in {
  # The everyday software suite. Every flip is mkDefault, so a host can turn
  # any of it back off without fighting the profile.
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
      libreoffice.enable = lib.mkDefault true;
      obs.enable = lib.mkDefault true;
      kdenlive.enable = lib.mkDefault true;
    };
  };
}

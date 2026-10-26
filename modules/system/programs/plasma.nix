{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.plasma;
in {
  config = lib.mkIf cfg.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = false;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      okular
      elisa
      gwenview
      ark
      spectacle
      khelpcenter

      konsole
      baloo-widgets

      kmahjongg
      kmines
      kpat
      union
      plasma-workspace-wallpapers
      aurorae
      ffmpegthumbs
      krdp
    ];
  };
}

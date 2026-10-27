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

    programs = {
      kde-pim.enable = false;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      okular
      elisa
      discover
      gwenview
      ark
      spectacle
      khelpcenter
      plasma-systemmonitor
      skanlite
      kwalletmanager
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

    nixpkgs.overlays = [
      (final: prev: let
        mkEmptyPkg = name: prev.runCommand "empty-${name}" {} "mkdir -p $out";
      in {
        kdePackages =
          prev.kdePackages
          // {
            skanpage = mkEmptyPkg "skanpage";
            discover = mkEmptyPkg "discover";
            plasma-systemmonitor = mkEmptyPkg "plasma-systemmonitor";
            drkonqi = mkEmptyPkg "drkonqi";
            kwalletmanager = mkEmptyPkg "kwalletmanager";
          };
      })
    ];
  };
}

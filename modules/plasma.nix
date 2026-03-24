{ pkgs, config, ...}:

{
  environment = {
    plasma6.excludePackages = with pkgs.kdePackages; [
      # --- Media ---
      elisa
      okular

      # --- Util ---
      kate
      kcalc
      ark
      spectacle
      
      # KDE etc shit
      discover
      baloo
      baloo-widgets

      # Akonadi
      kaddressbook
      akonadi
      akonadi-import-wizard
      print-manager
    ];
  };

services.xserver.excludePackages = [ pkgs.xterm ];

  documentation = {
    enable = false;
    nixos.enable = false;
  };
}
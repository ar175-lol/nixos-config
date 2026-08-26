{lib, ...}: {
  users.nixos.nixos.pc = {pkgs, ...}: {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.plasma-login-manager.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kwin-x11
      ark
      okular
      kate
      gwenview
      elisa
      discover
      plasma-browser-integration
    ];

    services.orca.enable = lib.mkForce false;
    programs.kde-pim.enable = lib.mkForce false;
    services.geoclue2.enable = lib.mkForce false;
  };
}

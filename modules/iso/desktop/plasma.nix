{
  inputs,
  lib,
  ...
}: {
  flake-file.inputs.plasma-manager = {
    url = "github:nix-community/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  users.nixos.home.gui = {
    imports = [inputs.plasma-manager.homeModules.plasma-manager];
  };

  users.nixos.nixos.pc = {pkgs, ...}: {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager = {
        plasma-login-manager.enable = true;
        defaultSession = "plasma";
      };
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

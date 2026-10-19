{
  lib,
  pkgs,
  ...
}: {
  config = {
    networking = {
      networkmanager.enable = lib.mkForce false;
      dhcpcd.enable = true;
      wireless.enable = lib.mkForce false;
    };

    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;

    hardware = {
      enableRedistributableFirmware = true;

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    programs.fish.enable = true;

    home-manager.backupFileExtension = "backup";

    environment.systemPackages = with pkgs; [
      debootstrap
      arch-install-scripts
      testdisk
      ddrescue
      chntpw
      ms-sys
      firefox
      calamares-nixos
    ];
  };
}

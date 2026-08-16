{lib, ...}: {
  users.nixos.nixos.base = {pkgs, ...}: {
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;
  };
}
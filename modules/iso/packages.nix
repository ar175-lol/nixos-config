_: {
  users.nixos.nixos.base = {pkgs, ...}: {
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
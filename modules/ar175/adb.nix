_: {
  users.ar175.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.android-tools
    ];
  };
}

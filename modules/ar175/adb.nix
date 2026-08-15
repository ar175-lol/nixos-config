_: {
  users.ar175.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      android-tools
    ];
  };
}

_: {
  users.ar175.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = [pkgs.kdePackages.kdenlive];
  };
}

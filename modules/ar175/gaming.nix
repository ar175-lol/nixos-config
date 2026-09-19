_: {
  users.ar175.nixos.pc = {pkgs, ...}: {
    programs.steam.enable = true;

    environment.systemPackages = [pkgs.qbittorrent pkgs.bottles];
  };
}

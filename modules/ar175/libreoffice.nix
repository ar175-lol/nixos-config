_: {
  users.ar175.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = [pkgs.libreoffice-stable pkgs.simple-scan];
    fonts.packages = with pkgs; [
      corefonts
      dejavu_fonts
    ];
  };
}

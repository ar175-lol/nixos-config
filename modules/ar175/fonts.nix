{
  users.ar175.nixos.pc = {pkgs, ...}: {
    fonts = {
      enableDefaultPackages = true;
      fontconfig = {
        enable = true;
        defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
      };
      packages = [pkgs.nerd-fonts.jetbrains-mono];
    };
  };
}

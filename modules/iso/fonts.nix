_: {
  users.nixos.nixos.base = {pkgs, ...}: {
    fonts = {
      packages = [pkgs.nerd-fonts.jetbrains-mono];
      fontconfig = {
        enable = true;
        defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
      };
    };
  };
}

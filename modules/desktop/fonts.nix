_: {
  nixos.desktop = {pkgs, ...}: {
    fonts = {
      enableDefaultPackages = true;
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = ["JetBrainsMono Nerd Font"];
        };
      };
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];
    };
  };
}

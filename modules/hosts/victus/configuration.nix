_: {
  nixos.victus = {pkgs, ...}: {
    networking.hostName = "victus";
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

    programs.steam.enable = true;

    system.stateVersion = "26.05";
  };
}

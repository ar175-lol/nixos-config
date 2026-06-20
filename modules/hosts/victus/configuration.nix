_: {
  nixos.victus = {pkgs, ...}: {
    networking.hostName = "victus";
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      jetbrains-mono
    ];
    system.stateVersion = "26.05";
  };
}

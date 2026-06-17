_: {
  nixos.victus = {pkgs, ...}: {
    networking.hostName = "victus";
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      jetbrains-mono
    ];
    programs.steam.enable = true;

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    system.stateVersion = "26.05";
  };
}

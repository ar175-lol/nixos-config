_: {
  nixos.victus = {pkgs, ...}: {
    networking.hostName = "victus";
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      jetbrains-mono
    ];
    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [nh];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NH_FLAKE = "/home/ar175/nix-test-v2";
    };

    system.stateVersion = "26.05";
  };
}

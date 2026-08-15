_: {
  users.ar175.home.base = {pkgs, ...}: {
    programs.direnv = {
      enable = true;
      silent = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    home.packages = with pkgs; [devenv];
  };
}

_: {
  nixos.home = {pkgs, ...}: {
    home = {
      username = "ar175";
      homeDirectory = "/home/ar175";

      stateVersion = "26.05";
      packages = with pkgs; [
        telegram-desktop
      ];
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        NH_FLAKE = "/home/ar175/nix-test-v2";
      };
    };
  };
}

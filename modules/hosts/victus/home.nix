_: {
  homeManager.ar175 = {pkgs, ...}: {
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
      };
    };
  };
}

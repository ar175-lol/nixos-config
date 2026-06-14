{self, ...}: {
  flake.homeModules.ar175 = {pkgs, ...}: {
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
    imports = [
      self.homeModules.myGit
      self.homeModules.myZsh
      self.homeModules.myStarship
      self.homeModules.myZen
      self.homeModules.mySpotify
      self.homeModules.myDiscord
      self.homeModules.myCursor
    ];
  };
}

{...}: {
  flake.homeModules.appsBundle = {self, ...}: {
    imports = [
      self.homeModules.myZen
      self.homeModules.myDiscord
      self.homeModules.mySpotify
    ];
  };
}

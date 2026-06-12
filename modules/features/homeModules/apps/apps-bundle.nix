{...}: {
  flake.homeModules.appsBundle = {self, ...}: {
    imports = [
      self.homeModules.myZen
      self.homeModules.myDiscord
      self.homeModules.myKitty
      self.homeModules.mySpotify
    ];
  };
}

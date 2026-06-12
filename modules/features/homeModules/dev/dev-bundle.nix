{...}: {
  flake.homeModules.devBundle = {self, ...}: {
    imports = [
      self.homeModules.myNvim
      self.homeModules.myFish
      self.homeModules.myGit
    ];
  };
}

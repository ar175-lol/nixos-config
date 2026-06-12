{self, ...}: {
  flake.homeModules.cliBundle = {...}: {
    imports = [
      self.homeModules.myFish
    ];
  };
}

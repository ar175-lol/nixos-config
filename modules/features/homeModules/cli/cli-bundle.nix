{self, ...}: {
  flake.homeModules.cliBundle = {...}: {
    imports = [
      self.homeModules.myZsh
      self.homeModules.myStarship
    ];
  };
}

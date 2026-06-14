{...}: {
  flake.homeModules.devBundle = {self, ...}: {
    imports = [
      self.homeModules.myGit
    ];
  };
}

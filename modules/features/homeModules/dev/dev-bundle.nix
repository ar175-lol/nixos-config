{...}: {
  flake.homeModules.devBundle = {self, ...}: {
    imports = [
      self.homeModules.myNvim
      self.homeModules.myGit
    ];
  };
}

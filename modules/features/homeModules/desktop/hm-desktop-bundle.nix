{self, ...}: {
  flake.homeModules.hmDesktopBundle = {...}: {
    imports = [
      self.homeModules.myCursor
    ];
  };
}

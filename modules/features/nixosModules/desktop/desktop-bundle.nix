{
  self,
  ...
}: {
  flake.nixosModules.desktopBundle = {...}: {
    imports = [
      self.nixosModules.xdgConfiguration
    ];
  };
}

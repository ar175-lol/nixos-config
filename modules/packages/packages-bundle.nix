{
  self,
  ...
}: {
  flake.nixosModules.packagesBundle = {
    imports = [
      self.nixosModules.niri

      self.nixosModules.yaziConfiguration
    ];
  };
}

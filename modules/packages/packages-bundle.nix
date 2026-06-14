{self, ...}: {
  flake.nixosModules.packagesBundle = {
    imports = [
      self.nixosModules.niri
      self.nixosModules.yaziConfiguration
      self.nixosModules.myKitty
      self.nixosModules.myNvim
    ];
  };
}

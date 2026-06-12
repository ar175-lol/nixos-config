{self, ...}: {
  flake.nixosModules.coreBundle = {
    imports = [
      self.nixosModules.systemdBootConfiguration
      self.nixosModules.nixConfiguration
      self.nixosModules.usersConfiguration
    ];
  };
}

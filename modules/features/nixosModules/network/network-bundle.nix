{self, ...}: {
  flake.nixosModules.networkBundle = {
    imports = [
      self.nixosModules.dnscryptConfiguration
      self.nixosModules.iwdConfiguration
      self.nixosModules.firewallConfiguration
      self.nixosModules.warpConfiguration
    ];
  };
}

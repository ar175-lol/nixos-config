{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.victus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.myVictusConfiguration
      self.nixosModules.myVictusHardware
      self.nixosModules.myHomeManager
      inputs.home-manager.nixosModules.home-manager
    ];
  };
}

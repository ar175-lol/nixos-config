{self, ...}: {
  flake.nixosModules.hardwareBundle = {...}: {
    imports = [
      self.nixosModules.bluetoothConfiguration
      self.nixosModules.nvidiaConfiguration
      self.nixosModules.zramConfiguration
      self.nixosModules.kernelConfiguration
      self.nixosModules.automountConfiguration
    ];
  };
}

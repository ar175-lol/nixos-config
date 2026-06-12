{self, ...}: {
  flake.nixosModules.servicesBundle = {
    imports = [
      self.nixosModules.pipewireConfiguration
      self.nixosModules.autocpufreqConfiguration
      self.nixosModules.xserverConfiguration
      self.nixosModules.systemDebloatConfiguration
    ];
  };
}

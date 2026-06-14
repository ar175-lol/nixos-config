{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.myHomeManager = {...}: {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {inherit inputs self;};
      backupFileExtension = "backup";
      users = {
        ar175 = self.homeModules.ar175;
      };
    };
  };
}

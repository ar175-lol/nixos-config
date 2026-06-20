{
  config,
  inputs,
  ...
}: {
  nixos.configurations.victus = {
    modules = [
      config.nixos.victus
      config.nixos.laptop
      inputs.home-manager.nixosModules.default
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit inputs;};
          backupFileExtension = "backup";
          users.ar175 = config.nixos.home;
        };
        nixpkgs.hostPlatform = "x86_64-linux";
      }
    ];
  };
}

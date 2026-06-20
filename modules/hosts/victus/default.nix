{
  config,
  inputs,
  ...
}: {
  nixos.configurations.victus = {
    modules = [
      config.nixos.base
      config.nixos.desktop
      config.nixos.victus
      inputs.home-manager.nixosModules.default
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          # TODO: remove extraSpecialArgs and fix infinite recursion
          extraSpecialArgs = {inherit inputs;};
          backupFileExtension = "backup";
          users.ar175 = config.nixos.home;
        };
        nixpkgs.hostPlatform = "x86_64-linux";
      }
    ];
  };
}

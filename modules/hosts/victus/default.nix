{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.victus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      config.nixos.base
      config.nixos.desktop
      config.nixos.victus
      inputs.home-manager.nixosModules.default
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          extraSpecialArgs = {inherit inputs;};
          backupFileExtension = "backup";
          users.ar175 = config.nixos.home;
        };
      }
    ];
  };
}

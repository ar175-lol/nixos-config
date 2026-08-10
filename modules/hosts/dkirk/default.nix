{
  config,
  inputs,
  ...
}: {
  nixos.configurations.dkirk = {
    modules = [
      config.nixos.pc
      config.nixos.kirk
      inputs.home-manager.nixosModules.default

      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit inputs;};
          backupFileExtension = "backup";
          users.kirk = config.homeManager.kirk; # TODO: split user configs between machines
        };
      }
    ];
  };
}

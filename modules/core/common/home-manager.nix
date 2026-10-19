{inputs, ...}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {inherit inputs;};

    sharedModules = [
      ({osConfig, ...}: {
        home.stateVersion = osConfig.system.stateVersion;
      })
    ];
  };
}

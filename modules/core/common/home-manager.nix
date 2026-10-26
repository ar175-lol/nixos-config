{inputs, ...}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    extraSpecialArgs = {inherit inputs;};
  };
}

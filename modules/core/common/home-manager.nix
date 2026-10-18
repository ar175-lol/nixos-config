{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  options.myUsers.homes = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
    description = "Accounts that should receive a home-manager generation.";
  };

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

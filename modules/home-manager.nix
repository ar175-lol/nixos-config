{
  mkModuleOption,
  inputs,
  ...
}: {
  options.homeManager.modules = {
    base = mkModuleOption {
      key = "base";
    };
    gui = mkModuleOption {
      key = "gui";
    };
  };

  config = {
    flake-file.inputs.home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homeManager.modules.base = _: {
      programs.home-manager.enable = true;
    };

    nixos.modules.base = {...}: {
      imports = [inputs.home-manager.nixosModules.home-manager];
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs;};
        sharedModules = [
          ({osConfig, ...}: {
            home.stateVersion = osConfig.system.stateVersion;
          })
        ];
      };
    };
  };
}

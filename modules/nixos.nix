{
  config,
  lib,
  inputs,
  ...
}: {
  options.nixos.configurations = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options.modules = lib.mkOption {
          type = lib.types.listOf lib.types.deferredModule;
          default = [];
        };
      }
    );
    default = {};
  };

  config.flake.nixosConfigurations =
    lib.mapAttrs (_: {modules, ...}: inputs.nixpkgs.lib.nixosSystem {inherit modules;}) config.nixos.configurations;
}

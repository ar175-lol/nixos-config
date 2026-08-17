{
  config,
  lib,
  inputs,
  ...
}: {
  options.nixOnDroid.configurations = lib.mkOption {
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

  config.flake.nixOnDroidConfigurations =
    lib.mapAttrs (_: {modules, ...}: inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      inherit modules;

      pkgs = import inputs.nixpkgs-phone {
        system = "aarch64-linux";
        overlays = [inputs.nix-on-droid.overlays.default];
      };

      home-manager-path = inputs.home-manager-phone.outPath;

      extraSpecialArgs = {inherit inputs;};
    }) config.nixOnDroid.configurations;
}
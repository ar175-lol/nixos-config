{
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    nixos = {
      base = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };

      desktop = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };

      victus = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };

      home = lib.mkOption {type = lib.types.deferredModule;};

      laptop = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };

      shell = lib.mkOption {
        type = lib.types.enum ["bash" "zsh" "fish"];
      };

      configurations = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule {
          options = {
            modules = lib.mkOption {
              type = lib.types.listOf lib.types.deferredModule;
              default = [];
            };
          };
        });
        default = {};
      };
    };
  };

  config.flake.nixosConfigurations =
    lib.mapAttrs (
      _: cfg:
        inputs.nixpkgs.lib.nixosSystem {
          inherit (cfg) modules;
        }
    )
    config.nixos.configurations;
}

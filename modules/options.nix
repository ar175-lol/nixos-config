{
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    homeManager = {
      kirk = lib.mkOption {type = lib.types.deferredModule;};
      ar175 = lib.mkOption {type = lib.types.deferredModule;};
      nixos = lib.mkOption {type = lib.types.deferredModule;};
    };
    nixos = {
      base = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };

      victus = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };
      kirk = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };

      iso = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };

      laptop = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };
      pc = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
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

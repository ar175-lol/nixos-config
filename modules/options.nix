{
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    homeManager.ar175 = lib.mkOption {type = lib.types.deferredModule;};
    homeManager.nixos = lib.mkOption {type = lib.types.deferredModule;};
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

      iso = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };

      # modules = lib.mkOption {
      #   type = lib.types.attrsOf lib.types.deferredModule;
      #   default = {};
      # };

      laptop = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };

      shell = lib.mkOption {
        type = lib.types.enum ["zsh" "fish"];
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

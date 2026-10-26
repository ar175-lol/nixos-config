{
  inputs,
  flakeRoot,
  lib,
  config,
  ...
}: let
  modulePath = flakeRoot + /modules;

  rolesPath = modulePath + /core/roles;

  commonTrees = [
    (modulePath + /options)
    (modulePath + /core/common)
    (modulePath + /core/profiles)
    (modulePath + /hardware)
    (modulePath + /system)
  ];

  userModule = name: spec: {pkgs, ...}: {
    users.users.${name} = {
      isNormalUser = true;
      useDefaultShell = true;
      inherit (spec) description extraGroups hashedPassword;
      home = spec.homeDirectory;
      shell = pkgs.${spec.shell};
    };

    home-manager.users.${name} = {osConfig, ...}: {
      imports = spec.homeModules;
      home.username = spec.username;
      home.homeDirectory = spec.homeDirectory;
      home.stateVersion = osConfig.system.stateVersion;
    };
  };

  mkHost = host:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};

      modules = lib.flatten [
        (map (tree: inputs.import-tree tree) commonTrees)
        (map (role: inputs.import-tree (rolesPath + "/${role}")) host.roles)
        host.extraModules
        host.features

        {
          networking.hostName = host.hostName;
          system.stateVersion = host.stateVersion;
        }

        (builtins.attrValues (
          lib.mapAttrs' (name: spec: lib.nameValuePair name (userModule name spec)) host.users
        ))
      ];
    };
in {
  imports = [./hosts.nix];

  options.hosts = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "build this host";

          hostName = lib.mkOption {
            type = lib.types.str;
            description = "networking.hostName for this machine.";
          };

          stateVersion = lib.mkOption {
            type = lib.types.str;
            description = "system.stateVersion for this machine.";
          };

          roles = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = ''
              What the machine IS, rather than what software it runs.

              Each entry names a directory under modules/core/roles. Every
              module in that directory is imported. A host can play several
              roles.
            '';
          };

          users = lib.mkOption {
            type = lib.types.attrsOf (
              lib.types.submodule (
                {name, ...}: {
                  options = {
                    username = lib.mkOption {
                      type = lib.types.str;
                      default = name;
                    };

                    homeDirectory = lib.mkOption {
                      type = lib.types.str;
                      default = "/home/${name}";
                    };

                    description = lib.mkOption {
                      type = lib.types.str;
                      default = "";
                    };

                    shell = lib.mkOption {
                      type = lib.types.str;
                      default = "bash";
                    };

                    extraGroups = lib.mkOption {
                      type = lib.types.listOf lib.types.str;
                      default = [];
                    };

                    hashedPassword = lib.mkOption {
                      type = lib.types.nullOr lib.types.str;
                      default = null;
                    };

                    homeModules = lib.mkOption {
                      type = lib.types.listOf lib.types.deferredModule;
                      default = [];
                      description = "Home Manager modules for this account.";
                    };
                  };
                }
              )
            );
            default = {};
            description = "Accounts to create. Each gets a matching home-manager generation.";
          };

          features = lib.mkOption {
            type = lib.types.deferredModule;
            default = {};
            description = "Per-host enable options and any direct config.";
          };

          extraModules = lib.mkOption {
            type = lib.types.listOf lib.types.deferredModule;
            default = [];
            description = "Modules imported only by this host.";
          };
        };
      }
    );
    default = {};
  };

  config.flake.nixosConfigurations = lib.mapAttrs (_: mkHost) (
    lib.filterAttrs (_: host: host.enable) config.hosts
  );
}

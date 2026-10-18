#
#
#
{
  inputs,
  lib,
  config,
  ...
}: let
  modulePath = ../../modules;

  rolesPath = modulePath + /core/roles;

  # Trees imported into every host, whatever its roles:
  #   options       - the option surface (device capabilities, profiles, programs)
  #   core/common   - the always-on baseline
  #   core/profiles - option-gated software bundles
  #   hardware      - opt-in hardware support behind modules.* flags
  #   system        - the boot loader and one module per opt-in program
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

    home-manager.users.${name} = {
      home.username = spec.username;
      home.homeDirectory = spec.homeDirectory;
    };
  };

  mkHost = host:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};

      modules = lib.flatten [
        (map (tree: inputs.import-tree tree) commonTrees)

        # Roles are imported per host: a machine only gets the trees for the
        # roles it plays. A role directory may hold several modules; all of
        # them are imported.
        (map (role: inputs.import-tree (rolesPath + "/${role}")) host.roles)

        host.extraModules

        host.features

        {
          networking.hostName = host.hostName;
          system.stateVersion = host.stateVersion;

          myUsers.homes = builtins.attrNames host.users;
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
                  };
                }
              )
            );
            default = {};
            description = "Accounts to create. Each gets a matching home-manager generation, and features attach to all of them via myUsers.homes.";
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

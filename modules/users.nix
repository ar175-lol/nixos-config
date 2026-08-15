{
  config,
  lib,
  mkModuleOption,
  ...
}: {
  options.users = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule (
        userArgs @ {name, ...}: {
          options = {
            username = lib.mkOption {
              type = lib.types.singleLineStr;
              default = name;
            };
            name = lib.mkOption {
              type = lib.types.nullOr lib.types.singleLineStr;
              default = null;
            };
            email = lib.mkOption {
              type = lib.types.nullOr lib.types.singleLineStr;
              default = null;
            };
            nixos = {
              base = mkModuleOption {
                key = "${name}-nixos-base";
                static = {
                  users.users.${name} = {
                    name = userArgs.config.username;
                    isNormalUser = true;
                    useDefaultShell = lib.mkDefault true;
                  };
                  home-manager.users.${name} = userArgs.config.home.base;
                };
              };
              pc = mkModuleOption {
                key = "${name}-nixos-pc";
                static = {
                  imports = [userArgs.config.nixos.base];
                  home-manager.users.${name} = userArgs.config.home.gui;
                };
              };
            };
            home = {
              base = mkModuleOption {
                key = "${name}-home-base";
                static = {
                  imports = [config.homeManager.modules.base];
                  home.username = lib.mkDefault userArgs.config.username;
                };
              };
              gui = mkModuleOption {
                key = "${name}-home-gui";
                static = {
                  imports = [
                    userArgs.config.home.base
                    config.homeManager.modules.gui
                  ];
                };
              };
            };
          };
        }
      )
    );
    default = {};
  };
}

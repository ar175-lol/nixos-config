{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.modules.system.services = {
    power-profiles-daemon.enable = mkEnableOption "power-profiles-daemon";
    thermald.enable = mkEnableOption "thermald (Intel thermal daemon)";
    undervolt = {
      enable = mkEnableOption "undervolt (Intel CPU undervolting)";

      p1 = {
        limit = mkOption {
          type = types.int;
          default = 30;
          description = "PL1 power limit in Watts.";
        };
        window = mkOption {
          type = types.int;
          default = 28;
          description = "PL1 time window in seconds.";
        };
      };

      p2 = {
        limit = mkOption {
          type = types.int;
          default = 45;
          description = "PL2 power limit in Watts.";
        };
        window = mkOption {
          type = types.float;
          default = 2.4;
          description = "PL2 time window in seconds.";
        };
      };
    };
  };
}

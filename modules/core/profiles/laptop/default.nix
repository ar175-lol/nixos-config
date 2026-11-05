{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
  cfg = config.modules.profiles.laptop;
in {
  config = lib.mkIf cfg.enable {
    modules.system = {
      services = {
        power-profiles-daemon.enable = mkDefault true;
        thermald.enable = mkDefault true;
        undervolt.enable = mkDefault true;
      };
      zram.enable = mkDefault true;
    };
  };
}

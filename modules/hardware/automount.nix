{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.automount;
in {
  config = lib.mkIf cfg.enable {
    fileSystems."/mnt/ventoy" = {
      device = "/dev/disk/by-uuid/4E21-0000";
      fsType = "exfat";
      options = [
        "noauto"
        "nofail"
        "uid=1000"
        "gid=1000"
        "umask=0022"
      ];
    };
  };
}

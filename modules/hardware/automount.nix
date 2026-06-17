_: {
  nixos.base = _: {
    fileSystems."/mnt/ventoy" = {
      device = "/dev/disk/by-uuid/4E21-0000";
      fsType = "exfat";
      options = [
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=600"
        "x-systemd.device-timeout=5"
        "nofail"
        "uid=1000"
        "gid=1000"
        "umask=0022"
      ];
    };
  };
}

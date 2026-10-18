{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.zram;
in {
  config = lib.mkIf cfg.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 100;
      memoryPercent = 100;
    };

    boot.kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.vfs_cache_pressure" = 50;
    };
  };
}

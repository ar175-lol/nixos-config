{lib, ...}: {
  config.modules.system = {
    powerSave.enable = lib.mkDefault true;
    zram.enable = lib.mkDefault true;
  };
}

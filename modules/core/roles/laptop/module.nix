{lib, ...}: {
  # The machine is portable. The actual tuning (undervolt values, zram
  # sizing, sysctls) lives in modules/hardware; this role only says what the
  # machine is.
  config.modules.system = {
    powerSave.enable = lib.mkDefault true;
    zram.enable = lib.mkDefault true;
  };
}

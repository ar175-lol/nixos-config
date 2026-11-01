{lib, ...}: {
  config = {
    modules.system.programs = {
      virtualisation.enable = lib.mkDefault true;
      adb.enable = lib.mkDefault true;
      printing.enable = lib.mkDefault true;
    };

    modules.system.doas.enable = lib.mkDefault true;
  };
}

{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.system.programs.printing.enable {
    hardware.printers = {
      ensurePrinters = [
        {
          name = "Pantum-Wireless-Driverless";
          description = "Pantum";
          deviceUri = "ipp://192.168.1.14/ipp/print";
          model = "everywhere";
          ppdOptions.PageSize = "A4";
        }
      ];
      ensureDefaultPrinter = "Pantum-Wireless-Driverless";
    };
  };
}

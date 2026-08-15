_: {
  nixos.modules.base = {
    config,
    lib,
    ...
  }: {
    assertions = [
      {
        assertion =
          (config.networking.hostName == "victus")
          -> (config.disko.devices.disk ? nixos);
        message = ''
          The host is identified as "victus", but the hardware configuration is missing.

          Make sure the hardware module is properly imported and evaluated.
        '';
      }
    ];
    warnings = lib.flatten [
      (lib.optional
        (config.networking.hostName == "victus" && !config.networking.wireless.iwd.enable)
        "iwd is disabled. You may lose wireless connectivity.")
    ];
  };
}

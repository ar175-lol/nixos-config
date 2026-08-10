_: {
  nixos.base = {
    config,
    lib,
    ...
  }: {
    assertions = [
      {
        assertion =
          (config.networking.hostName == "victus")
          -> (config.fileSystems ? "/"
            && config.fileSystems."/".device == "/dev/disk/by-uuid/fa37a150-d297-4056-a4fc-ea56431cbd95");
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

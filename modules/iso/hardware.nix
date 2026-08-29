_: {
  users.nixos.nixos.base = _: {
    hardware = {
      enableRedistributableFirmware = true;
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}

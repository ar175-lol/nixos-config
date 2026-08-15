_: {
  users.kirk.nixos.pc = _: {
    boot.loader = {
      timeout = 5;

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
  };
}

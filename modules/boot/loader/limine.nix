_: {
  users.ar175.nixos.pc = _: {
    boot.loader = {
      limine = {
        enable = true;
        efiSupport = true;
        maxGenerations = 5;
      };

      timeout = 0;
    };

    # stylix.targets.limine.enable = false;
  };
}

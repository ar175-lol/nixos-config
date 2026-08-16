{config, ...}: {
  nixos.configurations.victus.modules = [
    config.nixos.modules.base
    config.users.ar175.nixos.pc
    {
      networking.hostName = "victus";
      system.stateVersion = "26.05";
    }
  ];
}

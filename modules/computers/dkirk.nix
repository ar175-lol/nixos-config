{config, ...}: {
  nixos.configurations.dkirk.modules = [
    config.nixos.modules.base
    config.users.kirk.nixos.pc
    {
      networking.hostName = "dkirk";
      system.stateVersion = "26.11";
    }
  ];
}

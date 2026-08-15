{config, ...}: {
  nixos.configurations.dkirk.modules = [
    config.nixos.modules.pc
    config.users.kirk.nixos.pc
    {
      networking.hostName = "dkirk";
      nixpkgs.hostPlatform = "x86_64-linux";
      system.stateVersion = "26.11";
      time.timeZone = "Europe/Moscow";
      i18n.defaultLocale = "ru_RU.UTF-8";
    }
  ];
}

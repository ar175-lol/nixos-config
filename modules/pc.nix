{
  mkModuleOption,
  config,
  ...
}: {
  options.nixos.pc = mkModuleOption {
    key = "pc";
    static = {
      imports = with config.nixos; [
        hardware.amd
        modules.bluetooth
        network.nm
        network.firewall
        desktop.plasma
        boot.grub
        locale.kirk
        base
      ];
    };
  };
}

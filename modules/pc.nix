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
        desktop.fonts # Does my friend wants jetbrains mono nf? probably yeah...
        desktop.audio
        boot.grub
        locale.kirk
        base
      ];
    };
  };
}

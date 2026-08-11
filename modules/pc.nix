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
        desktop.fonts
        desktop.audio
        boot.grub
        locale.dkirk
        users.kirk
        base
        # You know, my friend? Fuck you, sit with bloated systemd.
      ];
    };
  };
}

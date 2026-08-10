{
  mkModuleOption,
  config,
  ...
}: {
  options.nixos.laptop = mkModuleOption {
    key = "laptop";
    static = {
      imports = with config.nixos; [
        modules.bluetooth
        network.iwd
        network.dnscrypt
        network.firewall
        desktop.niri
        desktop.fonts
        desktop.audio
        boot.limine
        locale.ar175
        apps.obs
        apps.yazi
        users.ar175
        base
        debloat
      ];
    };
  };
}

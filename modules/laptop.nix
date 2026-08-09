{
  mkModuleOption,
  config,
  ...
}: {
  options.nixos.laptop = mkModuleOption {
    key = "laptop";
    static = {
      imports = [
        config.nixos.modules.bluetooth
        config.nixos.modules.iwd
        config.nixos.desktop
        config.nixos.base
      ];
    };
  };
}

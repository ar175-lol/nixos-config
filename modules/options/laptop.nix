{
  mkModuleOption,
  config,
  ...
}: {
  options.nixos.modules.laptop = mkModuleOption {
    key = "laptop";
    static = config.nixos.modules.base;
  };
}

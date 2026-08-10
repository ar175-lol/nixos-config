{mkModuleOption, ...}: {
  options.nixos.apps.obs = mkModuleOption {key = "obs";};
  config.nixos.apps.obs = {
    programs.obs-studio.enable = true;
  };
}

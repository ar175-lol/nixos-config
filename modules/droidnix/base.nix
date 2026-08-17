{mkModuleOption, ...}: {
  options.nixOnDroid.modules.base = mkModuleOption {
    key = "nix-on-droid-base";
  };
}
{config, ...}: {
  nixOnDroid.configurations.default.modules = [
    config.nixOnDroid.modules.base
  ];
}
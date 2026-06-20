{
  config,
  lib,
  ...
}: {
  options.nixos.laptop = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
  };

  config.nixos.laptop = lib.mkMerge [
    config.nixos.desktop
    config.nixos.base
  ];
}

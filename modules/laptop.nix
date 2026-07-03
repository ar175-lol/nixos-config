{
  config,
  lib,
  ...
}: {
  config.nixos.laptop = lib.mkMerge [
    config.nixos.desktop
    config.nixos.base
  ];
}

{lib, ...}: {
  options = {
    nixos.base = lib.mkOption {type = lib.types.deferredModule;};
    nixos.desktop = lib.mkOption {type = lib.types.deferredModule;};
    nixos.victus = lib.mkOption {type = lib.types.deferredModule;};
    nixos.my-iso = lib.mkOption {type = lib.types.deferredModule;};
    nixos.home = lib.mkOption {type = lib.types.deferredModule;};
  };
}

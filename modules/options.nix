{lib, ...}: {
  options = {
    nixos = {
      base = lib.mkOption {type = lib.types.deferredModule;};
      desktop = lib.mkOption {type = lib.types.deferredModule;};
      victus = lib.mkOption {type = lib.types.deferredModule;};
      my-iso = lib.mkOption {type = lib.types.deferredModule;};
      home = lib.mkOption {type = lib.types.deferredModule;};
    };
  };
}

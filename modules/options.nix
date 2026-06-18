{lib, ...}: {
  options = {
    nixos = {
      base = lib.mkOption {
        type = lib.types.deferredModule;
        default = null;
      };
      desktop = lib.mkOption {
        type = lib.types.deferredModule;
        default = null;
      };
      victus = lib.mkOption {
        type = lib.types.deferredModule;
        default = null;
      };
      my-iso = lib.mkOption {type = lib.types.deferredModule;};
      home = lib.mkOption {type = lib.types.deferredModule;};
    };
  };
}

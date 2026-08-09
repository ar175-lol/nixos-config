{lib, ...}: {
  _module.args.mkModuleOption = args @ {
    key,
    static ? {},
    ...
  }:
    lib.mkOption {
      type = lib.types.deferredModuleWith {staticModules = [static];};
      apply = module: {
        inherit key;
        imports = [module];
      };
    };
}

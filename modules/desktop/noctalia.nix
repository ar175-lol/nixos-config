{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      inherit
        ((builtins.fromJSON
          (builtins.readFile ./assets/noctalia.json)))
        settings
        ;
    };
  };
}

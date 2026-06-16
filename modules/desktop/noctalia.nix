{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings =
        # Im lazy for doing ts
        (builtins.fromJSON
          (builtins.readFile ./assets/noctalia.json)).settings;
    };
  };
}

{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.myStarship = inputs.wrapper-modules.wrappers.starship.wrap {
      inherit pkgs;
      settings = fromTOML (builtins.readFile ../../../assets/starship.toml);
    };
  };
}

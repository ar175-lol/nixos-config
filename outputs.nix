inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  systems = ["x86_64-linux"];

  imports = [
    (inputs.import-tree ./modules/repository)

    (inputs.import-tree ./modules/tree)
  ];
  perSystem = {system, ...}: {
    formatter = inputs.nixpkgs.legacyPackages.${system}.alejandra;
  };

  debug = true;
}

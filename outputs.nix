inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  systems = ["x86_64-linux"];

  imports = [
    ./modules/core/common/system/programs/neovim/_package.nix
    ./modules/core/common/system/programs/noctalia/_package.nix
    ./hosts

    (inputs.import-tree ./modules/tree)
  ];
  perSystem = {system, ...}: {
    formatter = inputs.nixpkgs.legacyPackages.${system}.alejandra;
  };

  debug = true;
}

inputs: let
  flakeRoot = ./.;
in
  inputs.flake-parts.lib.mkFlake {
    inherit inputs;
    specialArgs = {inherit flakeRoot;};
  } {
    systems = ["x86_64-linux"];

    imports = [
      ./modules/system/programs/neovim/_package.nix
      ./modules/system/programs/noctalia/_package.nix

      (inputs.import-tree ./modules/repository)
      (inputs.import-tree ./modules/tree)
    ];
    perSystem = {system, ...}: {
      formatter = inputs.nixpkgs.legacyPackages.${system}.alejandra;
    };

    debug = true;
  }

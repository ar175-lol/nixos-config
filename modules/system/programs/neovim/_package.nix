{inputs, ...}: {
  perSystem = {system, ...}: let
    pkgs = inputs.nixpkgs.legacyPackages.${system};

    inherit
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;

        modules = [
          ({
            lib,
            pkgs,
            ...
          }: {
            config.vim = import ./_settings.nix {inherit lib pkgs;};
          })
        ];
      })
      neovim
      ;
  in {
    packages.myNeovim = neovim;

    apps.myNeovim = {
      type = "app";
      program = "${neovim}/bin/nvim";
    };
  };
}

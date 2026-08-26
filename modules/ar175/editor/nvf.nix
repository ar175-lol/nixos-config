{inputs, ...}: {
  flake-file.inputs.nvf = {
    url = "github:notashelf/nvf";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem = {config, pkgs, lib, ...}: {
    options.myNvf = {
      settings = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = {};
      };
    };

    config.packages.myNvf = (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [
        {config.vim = config.myNvf.settings;}
      ];
    }).neovim;
  };
}

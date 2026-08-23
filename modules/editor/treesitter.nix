_: {
  nixos.modules.base = {config, ...}: {
    programs.nixvim = {
      plugins = {
        treesitter = {
          enable = true;

          highlight.enable = true;

          indent = {
            enable = true;
            disable = ["nix"];
          };

          grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
            bash
            go
            json
            lua
            markdown
            nix
            yaml
            python
            rust
            toml
          ];
        };

        ts-autotag.enable = true;

        treesitter-textobjects.enable = true;
      };
    };
  };
}

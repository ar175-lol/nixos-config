_: {
  nixos.modules.base = {config, ...}: {
    programs.nixvim = {
      plugins = {
        treesitter = {
          enable = true;

          highlight.enable = true;
          indent.enable = true;

          grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
            bash
            go
            json
            lua
            markdown
            nix
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

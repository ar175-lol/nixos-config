{
  nixos.modules.base = _: {
    programs.nvf.settings.vim = {
      lsp = {
        enable = true;
        formatOnSave = true;
        inlayHints.enable = true;

        servers = {
          nixd.settings.nixd = {
            formatting.command = ["alejandra"];

            nixpkgs.expr = ''
              import (builtins.getFlake "/home/ar175/nixos-config").inputs.nixpkgs { }
            '';

            options = {
              nixos.expr = ''
                (builtins.getFlake "/home/ar175/nixos-config").nixosConfigurations.victus.options
              '';
              "home-manager".expr = ''
                (builtins.getFlake "/home/ar175/nixos-config").nixosConfigurations.victus.options.home-manager.users.type.getSubOptions []
              '';
              "flake-parts".expr = ''
                (builtins.getFlake "/home/ar175/nixos-config").debug.options
              '';
              "flake-parts-per-system".expr = ''
                (builtins.getFlake "/home/ar175/nixos-config").currentSystem.options
              '';
            };
          };

          lua-language-server.settings.Lua = {
            workspace.checkThirdParty = false;
            codeLens.enable = true;
            completion.callSnippet = "Replace";
            doc.privateName = ["^_"];
            hint = {
              enable = true;
              setType = false;
              paramType = true;
              paramName = "Disable";
              semicolon = "Disable";
              arrayIndex = "Disable";
            };
          };
        };
      };

      diagnostics = {
        enable = true;
        config = {
          severity_sort = true;
          update_in_insert = false;
          underline = true;
          signs = true;

          virtual_text = {
            spacing = 4;
            source = "if_many";
            prefix = "●";
          };
        };
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix = {
          enable = true;
          lsp.servers = ["nixd"];
          format.type = ["alejandra"];
          extraDiagnostics.types = ["statix" "deadnix"];
        };

        lua = {
          enable = true;
          extensions.lazydev.enable = true;
        };

        go.enable = true;

        python.enable = true;
        python.lsp.servers = ["ruff"];

        rust.enable = true;

        markdown = {
          enable = true;
          extensions.render-markdown-nvim.enable = true;
        };

        bash.enable = true;
        json.enable = true;
        yaml.enable = true;
        toml.enable = true;
      };

      treesitter = {
        autotagHtml = true;
        textobjects.enable = true;
        indent.excludes = ["nix"];
      };
    };
  };
}

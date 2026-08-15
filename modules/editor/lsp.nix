_: {
  nixos.modules.base = _: {
    programs.nixvim = {
      diagnostic.settings = {
        severity_sort = true;
        update_in_insert = false;

        virtual_text = {
          spacing = 4;
          source = "if_many";
          prefix = "●";
        };

        underline = true;
        signs = true;
      };

      lsp = {
        inlayHints.enable = true;

        keymaps = [
          {
            key = "<leader>cl";
            action.__raw = "Snacks.picker.lsp_config";
            options.desc = "LSP info";
          }
          {
            key = "gd";
            lspBufAction = "definition";
          }
          {
            key = "gr";
            lspBufAction = "references";
          }
          {
            key = "gI";
            lspBufAction = "implementation";
          }
          {
            key = "gy";
            lspBufAction = "type_definition";
          }
          {
            key = "gD";
            lspBufAction = "declaration";
          }
          {
            key = "K";
            lspBufAction = "hover";
          }
          {
            key = "gK";
            lspBufAction = "signature_help";
          }
          {
            key = "<C-k>";
            lspBufAction = "signature_help";
            mode = "i";
          }
          {
            key = "<leader>cr";
            lspBufAction = "rename";
          }
          {
            key = "<leader>ca";
            lspBufAction = "code_action";
          }
          {
            key = "<leader>ca";
            lspBufAction = "code_action";
            mode = "x";
          }
        ];

        servers = {
          "*".config = {
            capabilities = {
              workspace = {
                fileOperations = {
                  didRename = true;
                  willRename = true;
                };
              };
            };
          };

          nixd = {
            enable = true;

            config = {
              cmd = ["nixd"];
              filetypes = ["nix"];

              settings.nixd = {
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
            };
          };

          lua_ls = {
            enable = true;

            config = {
              cmd = ["lua-language-server"];
              filetypes = ["lua"];

              settings.Lua = {
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

          gopls = {
            enable = true;
            config = {
              cmd = ["gopls"];
              filetypes = ["go" "gomod" "gowork" "gotmpl"];
            };
          };

          ruff = {
            enable = true;
            config = {
              cmd = ["ruff" "server"];
              filetypes = ["python"];
            };
          };

          rust_analyzer = {
            enable = true;
            config = {
              cmd = ["rust-analyzer"];
              filetypes = ["rust"];
            };
          };
        };
      };
    };
  };
}

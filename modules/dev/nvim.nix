{inputs, ...}: {
  nixos.base = {pkgs, ...}: {
    imports = [inputs.nixvim.nixosModules.default];

    programs.nixvim = {
      enable = true;

      opts = {
        number = true;
        relativenumber = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        wrap = false;
        scrolloff = 8;
        signcolumn = "yes";
        updatetime = 100;
        termguicolors = true;
        cursorline = true;
        splitright = true;
        splitbelow = true;
      };

      colorschemes.gruvbox = {
        enable = true;
        settings.contrast_dark = "hard";
      };

      globals.mapleader = " ";

      keymaps = [
        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w>h";
          options.desc = "Move to left window";
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w>j";
          options.desc = "Move to lower window";
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w>k";
          options.desc = "Move to upper window";
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w>l";
          options.desc = "Move to right window";
        }

        {
          mode = "n";
          key = "<S-l>";
          action = ":bnext<CR>";
          options.desc = "Next buffer";
        }
        {
          mode = "n";
          key = "<S-h>";
          action = ":bprevious<CR>";
          options.desc = "Previous buffer";
        }

        {
          mode = "v";
          key = "<";
          action = "<gv";
          options.desc = "Indent left";
        }
        {
          mode = "v";
          key = ">";
          action = ">gv";
          options.desc = "Indent right";
        }

        {
          mode = "n";
          key = "<leader>h";
          action = ":nohlsearch<CR>";
          options.desc = "Clear highlights";
        }

        {
          mode = "n";
          key = "gd";
          action = "<cmd>lua vim.lsp.buf.definition()<CR>";
          options.desc = "Go to definition";
        }
        {
          mode = "n";
          key = "K";
          action = "<cmd>lua vim.lsp.buf.hover()<CR>";
          options.desc = "Hover docs";
        }
        {
          mode = "n";
          key = "<leader>rn";
          action = "<cmd>lua vim.lsp.buf.rename()<CR>";
          options.desc = "Rename symbol";
        }
        {
          mode = "n";
          key = "<leader>ca";
          action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
          options.desc = "Code action";
        }
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>Telescope find_files<CR>";
          options.desc = "Find files";
        }
        {
          mode = "n";
          key = "<leader>fg";
          action = "<cmd>Telescope live_grep<CR>";
          options.desc = "Live grep";
        }
        {
          mode = "n";
          key = "<leader>fb";
          action = "<cmd>Telescope buffers<CR>";
          options.desc = "Find buffers";
        }
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>Neotree toggle<CR>";
          options.desc = "File explorer";
        }
      ];

      plugins = {
        lsp = {
          enable = true;
          inlayHints = true;

          servers = {
            nixd = {
              enable = true;
              rootMarkers = ["flake.nix" ".git"];
              settings = {
                nixpkgs = {
                  expr = "import <nixpkgs> {}";
                };

                formatting.command = ["alejandra"];

                completion = {
                  auto = true;
                  startWithSpace = true;
                };

                target = {
                  path = "/home/ar175/nix-test-v2";
                  installable = ".#nixosConfigurations.victus";
                };

                options = {
                  nixos = {
                    expr = "(builtins.getFlake \"/home/ar175/nix-test-v2\").outputs.nixosConfigurations.victus.options";
                  };
                  home-manager = {
                    expr = "(builtins.getFlake \"/home/ar175/nix-test-v2\").outputs.nixosConfigurations.victus.options.home-manager.users.type.getSubOptions []";
                  };
                };
              };
            };
            pyright.enable = true;
            jsonls.enable = true;
          };
        };

        diagnostics = {
          virtual_text = {
            spacing = 4;
            prefix = "●";
          };
          signs = true;
          underline = true;
          severity_sort = true;
          update_in_insert = false;
        };

        autoCmd = [
          {
            event = ["CursorHold" "CursorHoldI"];
            callback = {
              __raw =
                # lua
                ''
                  function()
                    vim.diagnostic.open_float(nil, {
                      focusable    = false,
                      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                      border       = "rounded",
                      source       = "always",
                      scope        = "cursor",
                    })
                  end
                '';
            };
          }
        ];

        conform-nvim = {
          enable = true;
          settings = {
            formatters_by_ft = {
              nix = ["alejandra"];
              json = ["jq"];
            };
            format_on_save = {
              timeout_ms = 500;
              lsp_fallback = true;
            };
          };
        };

        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = false;
          folding.enable = false;
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            nix
            lua
            bash
            python
            markdown
          ];
        };
        blink-cmp = {
          enable = true;

          settings = {
            appearance = {
              nerd_font_variant = "normal";
              use_nvim_cmp_as_default = false;
            };

            sources.default = ["lsp" "path" "snippets" "buffer"];

            snippets.preset = "luasnip";

            completion = {
              accept.auto_brackets.enabled = true;
              documentation.auto_show = true;
            };
            signature.enabled = true;

            keymap = {
              preset = "none";

              "<Tab>" = [
                "select_next"
                "snippet_forward"
                "fallback"
              ];

              "<S-Tab>" = [
                "select_prev"
                "snippet_backward"
                "fallback"
              ];

              "<C-d>" = [
                "scroll_documentation_up"
                "fallback"
              ];
              "<C-f>" = [
                "scroll_documentation_down"
                "fallback"
              ];

              "<CR>" = [
                "accept"
                "fallback"
              ];
            };
          };
        };
        none-ls = {
          enable = true;
          sources = {
            diagnostics = {
              deadnix.enable = true;
            };
          };
        };

        lualine = {
          enable = true;
          settings.options.theme = "gruvbox";
        };

        nvim-autopairs = {
          enable = true;
          settings = {
            check_ts = true;
            disable_filetype = ["TelescopePrompt" "spectre_panel"];
          };
        };

        gitsigns.enable = true;
        comment.enable = true;
        which-key.enable = true;
        web-devicons.enable = true;
        nui-nvim.enable = true;
        nvim-notify.enable = true;
        luasnip.enable = true;
        telescope.enable = true;
        neo-tree.enable = true;
        trouble.enable = true;
        ts-context-commentstring.enable = true;
        rainbow-delimiters.enable = true;
      };
    };
  };
}

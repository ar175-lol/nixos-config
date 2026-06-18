{inputs, ...}: {
  nixos.base = {...}: {
    imports = [inputs.nixvim.nixosModules.default];

    programs.nixvim = {
      enable = true;
      waylandSupport = true;

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
        clipboard = "unnamedplus";
        showmode = false;
      };

      clipboard = {
        providers = {
          wl-copy.enable = true;
        };
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

      diagnostic = {
        settings = {
          virtual_text = {
            spacing = 4;
            prefix = "●";
          };
          signs = true;
          underline = true;
          severity_sort = true;
          update_in_insert = false;
        };
      };

      plugins = {
        lsp = {
          enable = true;
          inlayHints = true;

          onAttach = ''
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          '';

          servers = {
            nixd = {
              enable = true;
              rootMarkers = ["flake.nix" ".git"];
              settings = {
                nixpkgs = {
                  expr = "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs {}";
                };

                completion = {
                  auto = true;
                  startWithSpace = true;
                };

                options = {
                  nixos = {expr = "(builtins.getFlake \"/home/ar175/nix-test-v2\").nixosConfigurations.victus.options";};
                  home-manager = {expr = "(builtins.getFlake \"/home/ar175/nix-test-v2\").nixosConfigurations.victus.options.home-manager.users.type.getSubOptions []";};
                };
              };
            };
            pyright.enable = true;
            jsonls.enable = false; # Temporarily disabling this because jsonls is incompatible with Node.js v24
          };
        };

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
          nixvimInjections = true;
          folding.enable = false;
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

        neo-tree = {
          enable = true;

          settings = {
            close_if_last_window = true;

            filesystem = {
              filtered_items = {
                visible = true;
                show_hidden_count = true;
              };
            };
          };
        };

        none-ls = {
          enable = true;
          sources = {
            diagnostics = {
              deadnix.enable = true;
              statix.enable = true;
            };
          };
        };

        lualine = {
          enable = true;
          settings.options.theme = "gruvbox";
        };

        noice = {
          enable = true;
          settings = {
            cmdline.enabled = true;
            messages.enabled = true;
            popupmenu.enabled = true;

            views = {
              cmdline_popup = {
                position = {
                  row = "25%";
                  col = "50%";
                };
                size = {
                  width = 60;
                  height = "auto";
                };
              };
            };
          };
        };

        nvim-autopairs = {
          enable = true;
          settings = {
            check_ts = true;
            disable_filetype = ["TelescopePrompt" "spectre_panel"];
          };
        };

        auto-session = {
          enable = true;
          settings = {
            auto_restore_enabled = true;
            auto_save_enabled = true;
            auto_session_use_git_branch = false;
          };
        };

        gitsigns.enable = true;
        comment.enable = true;
        which-key.enable = true;
        web-devicons.enable = true;
        nui.enable = true;
        notify.enable = true;
        luasnip.enable = true;
        telescope.enable = true;
        ts-context-commentstring.enable = true;
        rainbow-delimiters.enable = true;
      };
    };
  };
}

_: {
  flake.homeModules.myNvim = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.nixvim.homeModules.nixvim];

    programs.nixvim = {
      enable = true;

      opts = {
        number = true;
        relativenumber = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        smartindent = true;
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

      plugins.lsp = {
        enable = true;
        servers = {
          nixd = {
            enable = true;
            settings = {
              #nixpkgs.expr = "import (builtins.getFlake \"/home/ar175/nix-test-v2\").inputs.nixpkgs { }";
              nixpkgs = {
                expr = "import <nixpkgs> {}";
              };
              formatting.command = ["alejandra"];
              completion.auto = true;
              completion.startWithSpace = true;
              target = {
                path = "/home/ar175/nix-test-v2";
                installable = ".#victus";
              };
              options = {
                nixos = {
                  expr = "(builtins.getFlake \"/home/ar175/nix-test-v2\").nixosConfigurations.victus.options";
                };
                home-manager = {
                  expr = "(builtins.getFlake \"/home/ar175/nix-test-v2\").nixosConfigurations.victus.options.home-manager.users.type.getSubOptions []";
                };
              };
            };
          };
          pyright.enable = true;
          jsonls.enable = true;
        };
        onAttach =
          # lua
          ''
            client.config.flags = client.config.flags or {}
            client.config.flags.debounce_text_changes = 0
          '';
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

      plugins.conform-nvim = {
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

      plugins.treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          ensure_installed = ["nix" "lua" "bash" "python"];
        };
      };
      plugins.cmp = {
        enable = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "buffer";}
            {name = "path";}
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
          };
        };
      };
      plugins.none-ls = {
        enable = true;
        sources = {
          diagnostics = {
            deadnix.enable = true;
          };
        };
      };
      plugins.cmp-nvim-lsp.enable = true;
      plugins.cmp-buffer.enable = true;
      plugins.cmp-path.enable = true;

      plugins.luasnip.enable = true;
      plugins.telescope.enable = true;
      plugins.neo-tree.enable = true;

      plugins.lualine = {
        enable = true;
        settings.options.theme = "gruvbox";
      };

      plugins.gitsigns.enable = true;
      plugins.nvim-autopairs.enable = true;
      plugins.comment.enable = true;
      plugins.which-key.enable = true;
      plugins.web-devicons.enable = true;
      plugins.nui-nvim.enable = true;
      plugins.nvim-notify.enable = true;

      extraPackages = with pkgs; [vimPlugins.snacks-nvim alejandra deadnix ripgrep tree-sitter fd jq];
    };
  };
}

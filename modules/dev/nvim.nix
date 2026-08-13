{luaGen, ...}: {
  nixos.base = {
    pkgs,
    lib,
    ...
  }: let
    inherit (luaGen) mkLuaInline genOption genGlobal genKeymap genAutocmd genCall genPlugin genLspAttach genFormatOnSave;

    vim = pkgs.vimPlugins;

    formatCapableLspNames = ["nixd"];

    globals = {
      mapleader = " ";
      tokyonight_style = "moon";
    };

    options = [
      {
        name = "number";
        value = true;
      }
      {
        name = "relativenumber";
        value = true;
      }
      {
        name = "signcolumn";
        value = "yes";
      }
      {
        name = "termguicolors";
        value = true;
      }
      {
        name = "cursorline";
        value = true;
      }
      {
        name = "expandtab";
        value = true;
      }
      {
        name = "shiftwidth";
        value = 2;
      }
      {
        name = "softtabstop";
        value = 2;
      }
      {
        name = "tabstop";
        value = 2;
      }
      {
        name = "ignorecase";
        value = true;
      }
      {
        name = "smartcase";
        value = true;
      }
      {
        name = "smartindent";
        value = true;
      }
      {
        name = "scrolloff";
        value = 8;
      }
      {
        name = "splitright";
        value = true;
      }
      {
        name = "splitbelow";
        value = true;
      }
      {
        name = "updatetime";
        value = 300;
      }
      {
        name = "undofile";
        value = true;
      }
      {
        name = "mouse";
        value = "a";
      }
      {
        name = "termsync";
        value = false;
      }
      {
        name = "completeopt";
        value = "menu,menuone,noselect";
      }
      {
        name = "pumheight";
        value = 10;
      }
      {
        name = "laststatus";
        value = 2;
      }
      {
        name = "sessionoptions";
        value = "blank,curdir,help,tabpages,winsize";
      }
      {
        name = "backup";
        value = false;
      }
      {
        name = "writebackup";
        value = false;
      }
      {
        name = "wrap";
        value = false;
      }
      {
        name = "clipboard";
        value = "unnamedplus";
        append = true;
      }
    ];

    keymaps = [
      {
        mode = "n";
        lhs = "<space><space>";
        rhs = "<Cmd>lua Snacks.picker.files()<CR>";
        desc = "Find files";
      }
      {
        mode = "n";
        lhs = "<space>ff";
        rhs = "<Cmd>lua Snacks.picker.files()<CR>";
        desc = "Find files";
      }
      {
        mode = "n";
        lhs = "<space>fr";
        rhs = "<Cmd>lua Snacks.picker.recent()<CR>";
        desc = "Recent files";
      }
      {
        mode = "n";
        lhs = "<space>fb";
        rhs = "<Cmd>lua Snacks.picker.buffers()<CR>";
        desc = "Buffers";
      }
      {
        mode = "n";
        lhs = "<space>fw";
        rhs = "<Cmd>lua Snacks.picker.grep_word()<CR>";
        desc = "Grep word";
      }
      {
        mode = "n";
        lhs = "<space>gt";
        rhs = "<Cmd>lua Snacks.picker.git_files()<CR>";
        desc = "Git files";
      }
      {
        mode = "n";
        lhs = "<space>e";
        rhs = "<Cmd>lua Snacks.explorer.open()<CR>";
        desc = "Explorer";
      }
      {
        mode = "n";
        lhs = "<space>s";
        rhs = "<Cmd>lua Snacks.picker.lsp_symbols()<CR>";
        desc = "LSP symbols";
      }
      {
        mode = "n";
        lhs = "<space>/";
        rhs = "<Cmd>lua Snacks.picker.grep()<CR>";
        desc = "Grep root dir";
      }
      {
        mode = "n";
        lhs = "<space>um";
        rhs = "<Cmd>RenderMarkdown toggle<CR>";
        desc = "Toggle markdown";
      }
      {
        mode = "n";
        lhs = "<space>qs";
        rhs = mkLuaInline "function() require('persistence').load() end";
        desc = "Restore session";
      }
      {
        mode = "n";
        lhs = "<space>ql";
        rhs = mkLuaInline "function() require('persistence').load({ last = true }) end";
        desc = "Restore last session";
      }
      {
        mode = "n";
        lhs = "<space>qd";
        rhs = mkLuaInline "function() require('persistence').stop() end";
        desc = "Stop session persistence";
      }
    ];

    lspKeymaps = [
      {
        key = "gd";
        fn = "definition";
      }
      {
        key = "gr";
        fn = "references";
      }
      {
        key = "gI";
        fn = "implementation";
      }
      {
        key = "gy";
        fn = "type_definition";
      }
      {
        key = "gD";
        fn = "declaration";
      }
      {
        key = "K";
        fn = "hover";
      }
      {
        key = "<C-k>";
        fn = "signature_help";
        mode = "i";
      }
      {
        key = "<space>cr";
        fn = "rename";
      }
      {
        key = "<space>ca";
        fn = "code_action";
      }
      {
        key = "<space>ca";
        fn = "code_action";
        mode = "x";
      }
    ];

    autocmds = [
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal nosmartindent indentexpr=";
      }
      {
        event = "FileType";
        callback = mkLuaInline "function() pcall(vim.treesitter.start) end";
      }
    ];

    calls = [
      {
        fn = "cmd.colorscheme";
        args = ["tokyonight"];
      }
      {
        fn = "diagnostic.config";
        args = [
          {
            severity_sort = true;
            update_in_insert = false;
            virtual_text = {
              spacing = 4;
              source = "if_many";
              prefix = "●";
            };
            underline = true;
            signs = true;
          }
        ];
      }
      {
        fn = "lsp.config";
        args = [
          "*"
          {
            capabilities = {
              workspace = {
                fileOperations = {
                  didRename = true;
                  willRename = true;
                };
              };
            };
          }
        ];
      }
      {
        fn = "lsp.config";
        args = [
          "nixd"
          {
            settings = {
              nixd = {
                formatting = {command = ["alejandra"];};
                nixpkgs = {
                  expr = mkLuaInline ''
                    string.format('import ((builtins.getFlake "%s").inputs.nixpkgs) {}', vim.fn.expand("~/nixos-config"))
                  '';
                };
                options = {
                  nixos = {
                    expr = mkLuaInline ''
                      string.format([[(let
                        f = builtins.getFlake "%s";
                        pkgs = import f.inputs.nixpkgs {};
                      in (pkgs.lib.evalModules {
                        modules = (import (f.inputs.nixpkgs + "/nixos/modules/module-list.nix")) ++ [
                          ({ ... }: { nixpkgs.hostPlatform = builtins.currentSystem; })
                        ];
                      }).options)]], vim.fn.expand("~/nixos-config"))
                    '';
                  };
                  "home-manager" = {
                    expr = mkLuaInline ''
                      string.format([[(let
                        f = builtins.getFlake "%s";
                        pkgs = import f.inputs.nixpkgs {};
                        hm = f.inputs.home-manager;
                        lib = import (hm + "/modules/lib/stdlib-extended.nix") pkgs.lib;
                      in (lib.evalModules {
                        modules = (import (hm + "/modules/modules.nix")) {
                          inherit lib pkgs;
                          check = false;
                        };
                      }).options)]], vim.fn.expand("~/nixos-config"))
                    '';
                  };
                  "flake-parts" = {
                    expr = mkLuaInline ''
                      string.format('(builtins.getFlake "%s").debug.options', vim.fn.expand("~/nixos-config"))
                    '';
                  };
                  "flake-parts-per-system" = {
                    expr = mkLuaInline ''
                      string.format('(builtins.getFlake "%s").currentSystem.options', vim.fn.expand("~/nixos-config"))
                    '';
                  };
                };
              };
            };
          }
        ];
      }
      {
        fn = "lsp.config";
        args = [
          "lua_ls"
          {
            settings = {
              Lua = {
                workspace = {checkThirdParty = false;};
                codeLens = {enable = true;};
                completion = {callSnippet = "Replace";};
                doc = {privateName = ["^_"];};
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
          }
        ];
      }
      {
        fn = "lsp.enable";
        args = [["nixd" "lua_ls" "gopls" "ruff" "statix" "rust_analyzer"]];
      }
    ];

    pluginSetups = [
      {
        module = "which-key";
        config = {preset = "helix";};
      }
      {
        module = "which-key";
        call = "add";
        config = [
          (mkLuaInline ''{ mode = { "n", "x" }, { "<leader><tab>", group = "tabs" }, { "<leader>c", group = "code" }, { "<leader>d", group = "debug" }, { "<leader>dp", group = "profiler" }, { "<leader>f", group = "file/find" }, { "<leader>g", group = "git" }, { "<leader>gh", group = "hunks" }, { "<leader>q", group = "quit/session" }, { "<leader>s", group = "search" }, { "<leader>u", group = "ui" }, { "<leader>x", group = "diagnostics/quickfix" }, { "[", group = "prev" }, { "]", group = "next" }, { "g", group = "goto" }, { "gs", group = "surround" }, { "z", group = "fold" }, { "<leader>b", group = "buffer", expand = function() return require("which-key.extras").expand.buf() end }, { "<leader>w", group = "windows", proxy = "<c-w>", expand = function() return require("which-key.extras").expand.win() end }, { "gx", desc = "Open with system app" } }'')
        ];
      }
      {
        module = "gitsigns";
        config = {};
      }
      {
        module = "lualine";
        config = {
          options = {
            theme = "tokyonight";
            component_separators = {
              left = "|";
              right = "|";
            };
            section_separators = {
              left = "";
              right = "";
            };
          };
        };
      }
      {
        module = "nvim-treesitter";
        config = {
          highlight = {enable = true;};
          indent = {
            enable = true;
            disable = ["nix"];
          };
          ensure_installed = {};
        };
      }
      {
        module = "nvim-ts-autotag";
        config = {};
      }
      {
        module = "blink.cmp";
        config = {
          keymap = {
            preset = "default";
            "<CR>" = ["accept" "fallback"];
            "<Tab>" = ["select_next" "fallback"];
            "<S-Tab>" = ["select_prev" "fallback"];
          };
          appearance = {nerd_font_variant = "mono";};
          sources = {
            default = ["lsp" "path" "snippets" "buffer"];
            per_filetype = {
              nix = ["lsp" "path" "snippets"];
              markdown = ["snippets" "path" "buffer" "lsp"];
            };
          };
          snippets = {
            expand = mkLuaInline "function(snippet, _) vim.snippet.expand(snippet) end";
            active = mkLuaInline "function() return vim.snippet.active() end";
            jump = mkLuaInline "function(direction) vim.snippet.jump(direction) end";
          };
          completion = {
            documentation = {auto_show = true;};
            menu = {
              draw = {
                columns = mkLuaInline ''
                  {
                    { "kind_icon" },
                    { "label", "label_description", gap = 1 },
                    { "source_name" },
                    { "kind" },
                  }
                '';
              };
            };
          };
          fuzzy = {implementation = "prefer_rust_with_warning";};
        };
      }
      {
        module = "snacks";
        config = {
          input = {enabled = false;};
          dashboard = {
            enabled = true;
            width = 36;
            preset = {
              keys = [
                {
                  icon = " ";
                  key = "f";
                  desc = "Find File";
                  action = "<Cmd>lua Snacks.dashboard.pick('files')<CR>";
                }
                {
                  icon = " ";
                  key = "n";
                  desc = "New File";
                  action = "<Cmd>ene | startinsert<CR>";
                }
                {
                  icon = " ";
                  key = "g";
                  desc = "Find Text";
                  action = "<Cmd>lua Snacks.dashboard.pick('live_grep')<CR>";
                }
                {
                  icon = " ";
                  key = "r";
                  desc = "Recent Files";
                  action = "<Cmd>lua Snacks.dashboard.pick('oldfiles')<CR>";
                }
                {
                  icon = " ";
                  key = "c";
                  desc = "Config";
                  action = "<Cmd>lua Snacks.explorer.open({ cwd = vim.fn.expand('~/nixos-config') })<CR>";
                }
                {
                  icon = " ";
                  key = "s";
                  desc = "Restore Session";
                  section = "session";
                }
                {
                  icon = " ";
                  key = "q";
                  desc = "Quit";
                  action = "<Cmd>qa<CR>";
                }
              ];
            };
            sections = [
              {padding = 1;}
              {section = "header";}
              {
                icon = " ";
                title = "Keymaps";
                section = "keys";
                indent = 2;
                padding = 1;
              }
              {
                icon = " ";
                title = "Recent Files";
                section = "recent_files";
                indent = 2;
                padding = 1;
              }
            ];
          };
          picker = {enabled = true;};
          explorer = {enabled = true;};
          rename = {enabled = true;};
          words = {enabled = true;};
          image = {enabled = false;};
          notifier = {enabled = false;};
          lazygit = {enabled = false;};
        };
      }
      {
        module = "noice";
        config = {
          cmdline = {
            enabled = true;
            view = "cmdline_popup";
          };
          messages = {enabled = true;};
          popupmenu = {enabled = true;};
          presets = {
            bottom_search = false;
            command_palette = true;
            long_message_to_split = true;
          };
        };
      }
      {
        module = "render-markdown";
        config = {
          code = {
            sign = false;
            width = "block";
            left_pad = 2;
            right_pad = 4;
          };
          heading = {sign = false;};
          checkbox = {enabled = false;};
          quote = {repeat_linebreak = true;};
          win_options = {
            showbreak = {
              default = "";
              rendered = "  ";
            };
            breakindent = {
              default = false;
              rendered = true;
            };
            breakindentopt = {
              default = "";
              rendered = "";
            };
          };
        };
      }
      {
        module = "mini.ai";
        config = {};
      }
      {
        module = "mini.pairs";
        config = {};
      }
      {
        module = "mini.surround";
        config = {};
      }
      {
        module = "mini.icons";
        config = {};
      }
      {
        module = "yanky";
        config = {highlight = {on_yank = true;};};
      }
      {
        module = "outline";
        config = {};
      }
      {
        module = "todo-comments";
        config = {};
      }
      {
        module = "persistence";
        config = {
          dir = mkLuaInline ''vim.fn.stdpath("state") .. "/sessions/"'';
          options = ["buffers" "curdir" "tabpages" "winsize" "help"];
        };
      }
      {
        module = "lazydev";
        config = {};
      }
      {
        module = "cord";
        config = {};
      }
    ];

    rawLua = [
      ''
        vim.api.nvim_create_autocmd("QuitPre", {
          callback = function()
            local snacks_windows = {}
            local floating_windows = {}
            local windows = vim.api.nvim_list_wins()
            for _, w in ipairs(windows) do
              local ft = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(w) })
              if ft:match("snacks_") ~= nil then
                table.insert(snacks_windows, w)
              elseif vim.api.nvim_win_get_config(w).relative ~= "" then
                table.insert(floating_windows, w)
              end
            end
            if 1 == #windows - #floating_windows - #snacks_windows then
              for _, w in ipairs(snacks_windows) do
                vim.api.nvim_win_close(w, true)
              end
            end
          end,
        })
      ''
      ''
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities and client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
          end,
        })
      ''
      ''
        local lint = require("lint")
        lint.linters_by_ft = {
          nix = { "statix" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
          callback = function()
            lint.try_lint()
          end,
        })
      ''
    ];

    customLuaRC = lib.concatStringsSep "\n\n" (lib.filter (s: s != "") [
      "vim.cmd.packloadall()"
      (lib.concatMapStringsSep "\n" (name: genGlobal name globals.${name}) (builtins.attrNames globals))
      (lib.concatMapStringsSep "\n" genOption options)
      (lib.concatMapStringsSep "\n" genKeymap keymaps)
      (genLspAttach lspKeymaps)
      (lib.concatMapStringsSep "\n" genAutocmd autocmds)
      (lib.concatMapStringsSep "\n" genCall calls)
      (lib.concatMapStringsSep "\n" genPlugin pluginSetups)
      (genFormatOnSave formatCapableLspNames)
      (lib.concatStringsSep "\n\n" rawLua)
    ]);

    treesitter = vim.nvim-treesitter.withPlugins (
      p: [
        p.tree-sitter-bash
        p.tree-sitter-diff
        p.tree-sitter-go
        p.tree-sitter-json
        p.tree-sitter-lua
        p.tree-sitter-markdown
        p.tree-sitter-markdown-inline
        p.tree-sitter-nix
        p.tree-sitter-python
        p.tree-sitter-rust
        p.tree-sitter-toml
        p.tree-sitter-yaml
      ]
    );

    plugins = with vim; [
      tokyonight-nvim
      which-key-nvim
      lualine-nvim
      gitsigns-nvim
      treesitter
      nvim-treesitter-textobjects
      nvim-ts-autotag
      nvim-lspconfig
      blink-cmp
      friendly-snippets
      snacks-nvim
      noice-nvim
      nui-nvim
      render-markdown-nvim
      mini-ai
      mini-pairs
      mini-surround
      mini-icons
      yanky-nvim
      outline-nvim
      persistence-nvim
      todo-comments-nvim
      nvim-lint
      lazydev-nvim
      cord-nvim
      plenary-nvim
    ];
  in {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      configure = {
        packages.myNeovim.start = plugins;

        inherit customLuaRC;
      };
    };

    environment.systemPackages = with pkgs; [
      alejandra
      fd
      gcc
      # go
      lua-language-server
      nixd
      ripgrep
      # ruff
      # rust-analyzer
      statix
      # stylua
      tree-sitter
      wl-clipboard
    ];
  };
}

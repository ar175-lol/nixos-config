_: {
  nixos.base = {
    pkgs,
    lib,
    ...
  }: let
    vim = pkgs.vimPlugins;

    toLua = v:
      if isNull v
      then "nil"
      else if builtins.isBool v
      then
        (
          if v
          then "true"
          else "false"
        )
      else if builtins.isInt v
      then toString v
      else if builtins.isFloat v
      then toString v
      else if builtins.isString v
      then ''"${lib.replaceStrings ["\\" "\"" "\n"] ["\\\\" "\\\"" "\\n"] v}"''
      else if builtins.isList v
      then "{ ${lib.concatMapStringsSep ", " toLua v} }"
      else if builtins.isAttrs v
      then v.__raw
        or "{ ${lib.concatStringsSep ", " (lib.mapAttrsToList (k: val: "${luaKey k} = ${toLua val}") v)} }"
      else throw "toLua: unsupported type ${builtins.typeOf v}";

    luaKey = k:
      if builtins.match "^[A-Za-z_][A-Za-z0-9_]*$" k != null
      then k
      else ''["${lib.replaceStrings ["\\" "\"" "\n"] ["\\\\" "\\\"" "\\n"] k}"]'';

    genOption = o:
      if o ? append
      then "vim.opt.${o.name}:append(${toLua o.value})"
      else "vim.opt.${o.name} = ${toLua o.value}";

    genGlobal = name: value: "vim.g.${name} = ${toLua value}";

    genKeymap = k: let
      opts = (k.opts or {}) // lib.optionalAttrs (k ? desc) {inherit (k) desc;};
    in "vim.keymap.set(${toLua k.mode}, ${toLua k.lhs}, ${toLua k.rhs}, ${toLua opts})";

    genAutocmd = a: "vim.api.nvim_create_autocmd(${toLua a.event}, ${toLua (lib.removeAttrs a ["event"])})";

    genCall = c: "vim.${c.fn}(${lib.concatMapStringsSep ", " toLua c.args})";

    genPlugin = p: "require(${toLua p.module}).${p.call or "setup"}(${toLua (p.config or {})})";

    genLspAttach = keymaps: ''
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local map = function(mode, keys, fn)
            vim.keymap.set(mode, keys, function() vim.lsp.buf[fn]() end, { buffer = args.buf, desc = "LSP: " .. fn })
          end
          ${lib.concatMapStringsSep "\n" (k: "map(${toLua (k.mode or "n")}, ${toLua k.key}, ${toLua k.fn})") keymaps}
        end,
      })
    '';

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
        rhs = {__raw = "function() require('persistence').load() end";};
        desc = "Restore session";
      }
      {
        mode = "n";
        lhs = "<space>ql";
        rhs = {__raw = "function() require('persistence').load({ last = true }) end";};
        desc = "Restore last session";
      }
      {
        mode = "n";
        lhs = "<space>qd";
        rhs = {__raw = "function() require('persistence').stop() end";};
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
        callback = {__raw = "function() pcall(vim.treesitter.start) end";};
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
                  expr = {
                    __raw = ''
                      string.format('import ((builtins.getFlake "%s").inputs.nixpkgs) {}', vim.fn.expand("~/nixos-config"))
                    '';
                  };
                };
                options = {
                  nixos = {
                    expr = {
                      __raw = ''
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
                  };
                  "home-manager" = {
                    expr = {
                      __raw = ''
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
                  };
                  "flake-parts" = {
                    expr = {
                      __raw = ''
                        string.format('(builtins.getFlake "%s").debug.options', vim.fn.expand("~/nixos-config"))
                      '';
                    };
                  };
                  "flake-parts-per-system" = {
                    expr = {
                      __raw = ''
                        string.format('(builtins.getFlake "%s").currentSystem.options', vim.fn.expand("~/nixos-config"))
                      '';
                    };
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
          {__raw = ''{ mode = { "n", "x" }, { "<leader><tab>", group = "tabs" }, { "<leader>c", group = "code" }, { "<leader>d", group = "debug" }, { "<leader>dp", group = "profiler" }, { "<leader>f", group = "file/find" }, { "<leader>g", group = "git" }, { "<leader>gh", group = "hunks" }, { "<leader>q", group = "quit/session" }, { "<leader>s", group = "search" }, { "<leader>u", group = "ui" }, { "<leader>x", group = "diagnostics/quickfix" }, { "[", group = "prev" }, { "]", group = "next" }, { "g", group = "goto" }, { "gs", group = "surround" }, { "z", group = "fold" }, { "<leader>b", group = "buffer", expand = function() return require("which-key.extras").expand.buf() end }, { "<leader>w", group = "windows", proxy = "<c-w>", expand = function() return require("which-key.extras").expand.win() end }, { "gx", desc = "Open with system app" } }'';}
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
            expand = {__raw = "function(snippet, _) vim.snippet.expand(snippet) end";};
            active = {__raw = "function() return vim.snippet.active() end";};
            jump = {__raw = "function(direction) vim.snippet.jump(direction) end";};
          };
          completion = {
            documentation = {auto_show = true;};
            menu = {
              draw = {
                columns = {
                  __raw = ''
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
                  icon = " ";
                  key = "f";
                  desc = "Find File";
                  action = "<Cmd>lua Snacks.dashboard.pick('files')<CR>";
                }
                {
                  icon = " ";
                  key = "n";
                  desc = "New File";
                  action = "<Cmd>ene | startinsert<CR>";
                }
                {
                  icon = " ";
                  key = "g";
                  desc = "Find Text";
                  action = "<Cmd>lua Snacks.dashboard.pick('live_grep')<CR>";
                }
                {
                  icon = " ";
                  key = "r";
                  desc = "Recent Files";
                  action = "<Cmd>lua Snacks.dashboard.pick('oldfiles')<CR>";
                }
                {
                  icon = " ";
                  key = "c";
                  desc = "Config";
                  action = "<Cmd>lua Snacks.explorer.open({ cwd = vim.fn.expand('~/nixos-config') })<CR>";
                }
                {
                  icon = " ";
                  key = "s";
                  desc = "Restore Session";
                  section = "session";
                }
                {
                  icon = " ";
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
                icon = " ";
                title = "Keymaps";
                section = "keys";
                indent = 2;
                padding = 1;
              }
              {
                icon = " ";
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
          dir = {__raw = ''vim.fn.stdpath("state") .. "/sessions/"'';};
          options = ["buffers" "curdir" "tabpages" "winsize" "help"];
        };
      }
      {
        module = "lazydev";
        config = {};
      }
      {
        module = "codex";
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
      (lib.concatStringsSep "\n\n" rawLua)
    ]);

    extraGrammars = {
      luadoc = pkgs.tree-sitter.buildGrammar {
        language = "luadoc";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "amaanq";
          repo = "tree-sitter-luadoc";
          rev = "4d04632a3a398b78af52e83be074883e722f40be";
          sha256 = "sha256-PgRCFFOqkNH63VZXr/0Kri3rXm2zmsq8nOEUlrlE1b4=";
        };
      };
      luap = pkgs.tree-sitter.buildGrammar {
        language = "luap";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "amaanq";
          repo = "tree-sitter-luap";
          rev = "c134aaec6acf4fa95fe4aa0dc9aba3eacdbbe55a";
          sha256 = "sha256-4mMUHBsdK4U4uhh8GpKlG3p/s3ZCcLX1qATPyTD4Xhg=";
        };
      };
      printf = pkgs.tree-sitter.buildGrammar {
        language = "printf";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "ObserverOfTime";
          repo = "tree-sitter-printf";
          rev = "ec4e5674573d5554fccb87a887c97d4aec489da7";
          sha256 = "sha256-JddrO4H7b3f/jrYag1lTAqeCzspf18SiIsVV2EJ25ZY=";
        };
      };
      vimdoc = pkgs.tree-sitter.buildGrammar {
        language = "vimdoc";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "neovim";
          repo = "tree-sitter-vimdoc";
          rev = "23daa416c1ff5d15f59a1aa648f031d6e3ee15c5";
          sha256 = "sha256-SG5oz/vXz1rdCjzAo2bE3xz107Hc+qOqfsC5V+j0X1I=";
        };
      };
    };

    treesitter = vim.nvim-treesitter.withPlugins (p:
      [
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
      ++ lib.attrValues extraGrammars);

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
      codex-nvim
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
      codex
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

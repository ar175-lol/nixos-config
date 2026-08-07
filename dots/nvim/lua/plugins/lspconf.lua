M = {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {},
  opts_extend = { "servers.*.keys" },
  opts = function()
    ---@class PluginLspOpts
    local ret = {
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
      inlay_hints = {
        enabled = true,
        exclude = { "vue" },
      },
      codelens = {
        enabled = false,
      },
      folds = {
        enabled = false,
      },
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        ["*"] = {
          capabilities = {
            workspace = {
              fileOperations = {
                didRename = true,
                willRename = true,
              },
            },
          },
          keys = {
            {
              "<leader>cl",
              function()
                Snacks.picker.lsp_config()
              end,
              desc = "Lsp Info",
            },
            {
              "gd",
              vim.lsp.buf.definition,
              desc = "Goto Definition",
              has = "definition",
            },
            {
              "gr",
              vim.lsp.buf.references,
              desc = "References",
              nowait = true,
            },
            { "gI", vim.lsp.buf.implementation,  desc = "Goto Implementation" },
            { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
            { "gD", vim.lsp.buf.declaration,     desc = "Goto Declaration" },
            {
              "K",
              function()
                return vim.lsp.buf.hover()
              end,
              desc = "Hover",
            },
            {
              "gK",
              function()
                return vim.lsp.buf.signature_help()
              end,
              desc = "Signature Help",
              has = "signatureHelp",
            },
            {
              "<c-k>",
              function()
                return vim.lsp.buf.signature_help()
              end,
              mode = "i",
              desc = "Signature Help",
              has = "signatureHelp",
            },
            {
              "<leader>ca",
              vim.lsp.buf.code_action,
              desc = "Code Action",
              mode = { "n", "x" },
              has = "codeAction",
            },
            {
              "<leader>cR",
              function()
                Snacks.rename.rename_file()
              end,
              desc = "Rename File",
              mode = { "n" },
              has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
            },
            {
              "<leader>cr",
              vim.lsp.buf.rename,
              desc = "Rename",
              has = "rename",
            },
            {
              "<leader>cA",
              LazyVim.lsp.action.source,
              desc = "Source Action",
              has = "codeAction",
            },
            {
              "]]",
              function()
                Snacks.words.jump(vim.v.count1)
              end,
              has = "documentHighlight",
              desc = "Next Reference",
              enabled = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "[[",
              function()
                Snacks.words.jump(-vim.v.count1)
              end,
              has = "documentHighlight",
              desc = "Prev Reference",
              enabled = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "<a-n>",
              function()
                Snacks.words.jump(vim.v.count1, true)
              end,
              has = "documentHighlight",
              desc = "Next Reference",
              enabled = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "<a-p>",
              function()
                Snacks.words.jump(-vim.v.count1, true)
              end,
              has = "documentHighlight",
              desc = "Prev Reference",
              enabled = function()
                return Snacks.words.is_enabled()
              end,
            },
          },
        },

        gopls = {},
        statix = {},
        ruff = {},
        rust_analyzer = {},
        nixd = {
          settings = {
            nixd = {
              formatting = {
                command = { "alejandra" },
              },
              nixpkgs = {
                expr = string.format(
                  'import ((builtins.getFlake "%s").inputs.nixpkgs) {}',
                  vim.fn.expand("~/nixos-config")
                ),
              },
              options = (function()
                local flake = vim.fn.expand("~/nixos-config")
                return {
                  nixos = {
                    expr = string.format(
                      [[(let
                        flake = builtins.getFlake "%s";
                        pkgs = import flake.inputs.nixpkgs {};
                      in (pkgs.lib.evalModules {
                        modules = (import "${flake.inputs.nixpkgs}/nixos/modules/module-list.nix") ++ [
                          ({ ... }: { nixpkgs.hostPlatform = builtins.currentSystem; })
                      ];
                      }).options)]],
                      flake
                    ),
                  },
                  ["home-manager"] = {
                    expr = string.format(
                      [[(let
                flake = builtins.getFlake "%s";
                pkgs = import flake.inputs.nixpkgs {};
                lib = import "${flake.inputs["home-manager"]}/modules/lib/stdlib-extended.nix" pkgs.lib;
              in (lib.evalModules {
                modules = (import "${flake.inputs["home-manager"]}/modules/modules.nix") {
                  inherit lib pkgs;
                  check = false;
                };
              }).options)]],
                      flake
                    ),
                  },
                  ["flake-parts"] = {
                    expr = string.format('(builtins.getFlake "%s").debug.options', flake),
                  },
                  ["flake-parts-per-system"] = {
                    expr = string.format('(builtins.getFlake "%s").currentSystem.options', flake),
                  },
                }
              end)(),
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
      },
      jqls = { enabled = false },
      texlab = { enabled = false },
      clangd = { enabled = false },
      helm_ls = { enabled = false },
      luau_lsp = { enabled = false },
      ---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    }
    return ret
  end,
  ---@param opts PluginLspOpts
  config = vim.schedule_wrap(function(_, opts)
    -- setup autoformat
    LazyVim.format.register(LazyVim.lsp.formatter())

    -- setup keymaps
    for server, server_opts in pairs(opts.servers) do
      if type(server_opts) == "table" and server_opts.keys then
        require("lazyvim.plugins.lsp.keymaps").set({ name = server ~= "*" and server or nil }, server_opts.keys)
      end
    end

    if opts.inlay_hints.enabled then
      Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
        if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].buftype == ""
            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
        then
          vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end
      end)
    end

    if opts.folds.enabled then
      Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function()
        if LazyVim.set_default("foldmethod", "expr") then
          LazyVim.set_default("foldexpr", "v:lua.vim.lsp.foldexpr()")
        end
      end)
    end

    if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = function(diagnostic)
        local icons = LazyVim.config.icons.diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
        return "●"
      end
    end
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    if opts.servers["*"] then
      vim.lsp.config("*", opts.servers["*"])
    end

    for server, server_opts in pairs(opts.servers) do
      if server ~= "*" then
        server_opts = server_opts == true and {} or (not server_opts) and { enabled = false } or
            server_opts --[[@as lazyvim.lsp.Config]]
        if server_opts.enabled ~= false then
          local setup = opts.setup[server] or opts.setup["*"]
          if not (setup and setup(server, server_opts)) then
            vim.lsp.config(server, server_opts)
            vim.lsp.enable(server)
          end
        end
      end
    end
  end),
}

return M

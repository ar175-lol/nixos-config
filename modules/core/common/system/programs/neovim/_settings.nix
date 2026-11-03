{
  lib,
  pkgs,
}: let
  # These strings are Nix expressions evaluated by nixd at runtime, not at
  # build time, so they resolve against whoever runs the editor. The checkout
  # is expected at ~/nixos-config (same convention as nh and noctalia-sync).
  flake = ''(builtins.getFlake (builtins.getEnv "HOME" + "/nixos-config"))'';
  host = ''(builtins.replaceStrings ["\n"] [""] (builtins.readFile "/etc/hostname"))'';
  nixosConfig = "(builtins.getAttr ${host} ${flake}.nixosConfigurations)";
in {
  theme = {
    enable = true;
    name = "catppuccin";
    style = "mocha";
    transparent = false;
  };

  viAlias = true;
  vimAlias = true;

  extraPackages = [
    pkgs.ripgrep
    pkgs.fd
  ];

  opts = {
    termsync = false; # fix tmux cursor issue
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    smartcase = true;
    splitright = true;
    splitbelow = true;
    clipboard = "unnamedplus";
    mouse = "a";
    termguicolors = true;
    autoindent = true;
    smartindent = true; # why i have this true? i dont remember lol
  };

  autocomplete = {
    nvim-cmp.enable = lib.mkForce false;
    blink-cmp.enable = true;
  };

  lsp = {
    enable = true;
    formatOnSave = true;

    presets.nil.enable = lib.mkForce false;

    servers.nixd = {
      enable = true;
      settings.nixd = {
        formatting.command = ["alejandra"];

        nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";

        options = {
          # nixd resolves option paths from the lexical attrpath. Host files
          # assign under `hosts.<name>.features`, which is a deferredModule;
          # nixd cannot expand it. Mirror the NixOS options there so custom
          # `modules.*` options still complete in `hosts/<name>/host.nix`.
          nixos.expr = ''
            let
              flake = ${flake};
              nixosOptions = (builtins.getAttr ${host} flake.nixosConfigurations).options;
            in
              nixosOptions
              // {
                hosts = builtins.mapAttrs
                  (name: _: {features = (builtins.getAttr name flake.nixosConfigurations).options;})
                  flake.nixosConfigurations;
              }
          '';
          home-manager.expr = "${nixosConfig}.options.home-manager.users.type.getSubOptions []";
          flake-parts.expr = "${flake}.debug.options";
          flake-parts-per-system.expr = "${flake}.currentSystem.options";
        };
      };
    };

    servers.gopls.enable = true;
  };

  languages = {
    enableFormat = true;
    enableTreesitter = true;

    nix = {
      enable = true;
      lsp.servers = ["nixd"];
      format.type = ["alejandra"];
    };
    go.enable = true;
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

  utility.snacks-nvim = {
    enable = true;

    setupOpts = {
      explorer = {
        enabled = false;
        replace_netrw = true;
        trash = false;
      };

      picker.enabled = true;

      indent = {
        enabled = true;
        chunk.enabled = true;
      };

      image.enabled = true;
      terminal.enabled = false;
      lazygit.enabled = false;
      notifier.enabled = false;
      dashboard.enabled = false;
      zen.enabled = false;
    };
  };

  luaConfigRC = {
    disable_netrw = ''
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
            vim.schedule(function()
              Snacks.picker.files()
            end)
          end
        end,
      })
    '';

    snacks_indent_colors = ''
      local function snacks_indent_colors()
        vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#585b70" })
        vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#cba6f7" })
        vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = "#cba6f7" })
      end

      snacks_indent_colors()
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, { callback = snacks_indent_colors })
    '';
  };

  visuals.nvim-web-devicons.enable = true;

  keymaps = [
    {
      key = "<ESC>";
      mode = "n";
      lua = false;
      action = "<cmd>noh<cr>";
      desc = "Clear search highlights";
    }
    {
      key = "<leader>ff";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.files({ hidden = true, ignored = true }) end";
      desc = "Find files";
    }
    {
      key = "<leader>fg";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.grep({ hidden = true, ignored = true }) end";
      desc = "Live grep";
    }
    {
      key = "<leader>fh";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.help() end";
      desc = "Help tags";
    }
    {
      key = "<leader>ft";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.files() end";
      desc = "Open";
    }
    {
      key = "<leader>fr";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.resume() end";
      desc = "Resume (previous search)";
    }
    {
      key = "<leader>fvcw";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.git_log() end";
      desc = "Git commits";
    }
    {
      key = "<leader>fvcb";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.git_log_file() end";
      desc = "Git buffer commits";
    }
    {
      key = "<leader>fvb";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.git_branches() end";
      desc = "Git branches";
    }
    {
      key = "<leader>fvs";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.git_status() end";
      desc = "Git status";
    }
    {
      key = "<leader>fvx";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.git_stash() end";
      desc = "Git stash";
    }
    {
      key = "<leader>fld";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.diagnostics({ cwd = true }) end";
      desc = "Diagnostics";
    }
  ];

  git = {
    enable = true;
    gitsigns.enable = true;
    gitsigns.codeActions.enable = false;
  };

  mini = {
    surround.enable = true;
    ai.enable = true;
    pairs.enable = true;
  };

  statusline.lualine.enable = true;

  formatter.conform-nvim.presets.deno.enable = lib.mkForce false;
  tabline.nvimBufferline.enable = false;
  binds.whichKey = {
    enable = true;
    setupOpts = {
      icons = {
        rules = [
          {
            pattern = "grep";
            icon = " ";
            color = "green";
          }
          {
            pattern = "files";
            icon = " ";
            color = "green";
          }
        ];
      };
    };
  };
  ui.noice = {
    enable = true;

    setupOpts = {
      cmdline.enabled = true;

      presets = {
        bottom_search = false;
        command_palette = true;
      };
    };
  };
}

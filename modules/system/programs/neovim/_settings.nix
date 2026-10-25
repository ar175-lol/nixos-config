{
  lib,
  pkgs,
}: {
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

        nixpkgs.expr = ''
          import (builtins.getFlake "/home/ar175/nixos-config").inputs.nixpkgs { }
        '';

        options = {
          nixos.expr = "(builtins.getFlake \"/home/ar175/nixos-config\").nixosConfigurations.apollo.options";
          home-manager.expr = "(builtins.getFlake \"/home/ar175/nixos-config\").nixosConfigurations.apollo.options.home-manager.users.type.getSubOptions []";
          flake-parts.expr = "(builtins.getFlake \"/home/ar175/nixos-config\").debug.options";
          flake-parts-per-system.expr = "(builtins.getFlake \"/home/ar175/nixos-config\").currentSystem.options";
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
        enabled = true;
        replace_netrw = true;
        trash = false;
      };

      picker.enabled = true;

      indent = {
        enabled = true;
        chunk.enabled = true;
      };

      image.enabled = false;
      terminal.enabled = false;
      lazygit.enabled = false;
      notifier.enabled = false;
      dashboard.enabled = false;
      zen.enabled = false;
    };
  };

  luaConfigRC.snacks_indent_colors = ''
    local function snacks_indent_colors()
      vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#585b70" })
      vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#cba6f7" })
      vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = "#cba6f7" })
    end

    snacks_indent_colors()
    vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, { callback = snacks_indent_colors })
  '';

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
      key = "<leader>e";
      mode = "n";
      lua = true;
      action = "function() Snacks.explorer.open() end";
      desc = "Explorer";
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
      action = "function() Snacks.picker.grep() end";
      desc = "Live grep";
    }
    {
      key = "<leader>fb";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.buffers() end";
      desc = "Buffers";
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
      key = "<leader>fvf";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.git_files() end";
      desc = "Git files";
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
      key = "<leader>flr";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.lsp_references() end";
      desc = "LSP References";
    }
    {
      key = "<leader>flD";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.lsp_definitions() end";
      desc = "LSP Definitions";
    }
    {
      key = "<leader>flt";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.lsp_type_definitions() end";
      desc = "LSP Type Definitions ";
    }
    {
      key = "<leader>fld";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.diagnostics({ cwd = true }) end";
      desc = "Diagnostics";
    }
    {
      key = "<leader>fs";
      mode = "n";
      lua = true;
      action = "function() Snacks.picker.treesitter() end";
      desc = "Treesitter";
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
  binds.whichKey.enable = true;
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

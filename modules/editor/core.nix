_: {
  nixos.modules.base = _: {
    programs.nixvim = {
      globals.mapleader = " ";

      opts = {
        number = true;
        relativenumber = true;
        signcolumn = "yes";
        termguicolors = true;
        cursorline = true;
        expandtab = true;
        shiftwidth = 2;
        softtabstop = 2;
        tabstop = 2;
        ignorecase = true;
        smartcase = true;
        smartindent = true;
        scrolloff = 8;
        splitright = true;
        splitbelow = true;
        updatetime = 300;
        undofile = true;
        mouse = "a";
        termsync = false;
        completeopt = "menu,menuone,noselect";
        pumheight = 10;
        laststatus = 2;
        sessionoptions = "blank,curdir,help,tabpages,winsize";
        backup = false;
        writebackup = false;
        wrap = false;
        clipboard = "unnamedplus";
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader><space>";
          action = "<Cmd>lua Snacks.picker.files()<CR>";
          options.desc = "Find files";
        }
        {
          mode = "n";
          key = "<leader>ff";
          action = "<Cmd>lua Snacks.picker.files()<CR>";
          options.desc = "Find files";
        }
        {
          mode = "n";
          key = "<leader>fr";
          action = "<Cmd>lua Snacks.picker.recent()<CR>";
          options.desc = "Recent files";
        }
        {
          mode = "n";
          key = "<leader>fb";
          action = "<Cmd>lua Snacks.picker.buffers()<CR>";
          options.desc = "Buffers";
        }
        {
          mode = "n";
          key = "<leader>fw";
          action = "<Cmd>lua Snacks.picker.grep_word()<CR>";
          options.desc = "Grep word";
        }
        {
          mode = "n";
          key = "<leader>gt";
          action = "<Cmd>lua Snacks.picker.git_files()<CR>";
          options.desc = "Git files";
        }
        {
          mode = "n";
          key = "<leader>e";
          action = "<Cmd>lua Snacks.explorer.open()<CR>";
          options.desc = "Explorer";
        }
        {
          mode = "n";
          key = "<leader>s";
          action = "<Cmd>lua Snacks.picker.lsp_symbols()<CR>";
          options.desc = "LSP symbols";
        }
        {
          mode = "n";
          key = "<leader>/";
          action = "<Cmd>lua Snacks.picker.grep()<CR>";
          options.desc = "Grep root dir";
        }
        {
          mode = "n";
          key = "<leader>um";
          action = "<Cmd>RenderMarkdown toggle<CR>";
          options.desc = "Toggle markdown";
        }
        {
          mode = "n";
          key = "<leader>cp";
          action = "<Cmd>MarkdownPreviewToggle<CR>";
          options.desc = "Markdown preview";
        }
        {
          mode = "n";
          key = "<leader>qs";
          action.__raw = "function() require('persistence').load() end";
          options.desc = "Restore session";
        }
        {
          mode = "n";
          key = "<leader>ql";
          action.__raw = "function() require('persistence').load({ last = true }) end";
          options.desc = "Restore last session";
        }
        {
          mode = "n";
          key = "<leader>qd";
          action.__raw = "function() require('persistence').stop() end";
          options.desc = "Stop session persistence";
        }
      ];

      autoGroups = {
        nixvim_autocmds.clear = true;
      };

      autoCmd = [
        {
          event = ["FileType"];
          pattern = "nix";
          command = "setlocal nosmartindent";
        }
        {
          event = ["FileType"];
          callback.__raw = "function() pcall(vim.treesitter.start) end";
        }
      ];
    };
  };
}

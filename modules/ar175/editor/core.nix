{inputs, ...}: {
  flake-file.inputs.nvf.url = "github:notashelf/nvf";

  users.ar175.home.base.home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  nixos.modules.base = {pkgs, ...}: {
    imports = [inputs.nvf.nixosModules.nvf];

    programs.nvf = {
      enable = true;
      defaultEditor = true;

      settings.vim = {
        searchCase = "smart";
        undoFile.enable = true;

        luaConfigRC.lsp-restart = ''
          vim.api.nvim_create_user_command("LspRestart", function()
            local clients = vim.lsp.get_clients()
            if #clients == 0 then return end
            for _, client in ipairs(clients) do
              client:stop()
            end
            vim.defer_fn(function() vim.cmd("silent! checktime edit") end, 300)
          end, { desc = "Restart LSP servers" })
        '';

        opts = {
          signcolumn = "yes";
          cursorline = true;
          shiftwidth = 2;
          softtabstop = 2;
          tabstop = 2;
          smartindent = false;
          scrolloff = 8;
          splitright = true;
          splitbelow = true;
          updatetime = 300;
          mouse = "a";
          termsync = false;
          completeopt = "menu,menuone,noselect";
          pumheight = 10;
          laststatus = 2;
          clipboard = "unnamedplus";
        };

        keymaps = [
          {
            mode = "n";
            key = "<leader>ff";
            action = "function() Snacks.picker.files() end";
            lua = true;
            desc = "Find files";
          }
          {
            mode = "n";
            key = "<leader>fr";
            action = "function() Snacks.picker.recent() end";
            lua = true;
            desc = "Recent files";
          }
          {
            mode = "n";
            key = "<leader>fb";
            action = "function() Snacks.picker.buffers() end";
            lua = true;
            desc = "Buffers";
          }
          {
            mode = "n";
            key = "<leader>fw";
            action = "function() Snacks.picker.grep_word() end";
            lua = true;
            desc = "Grep word";
          }
          {
            mode = "n";
            key = "<leader>gt";
            action = "function() Snacks.picker.git_files() end";
            lua = true;
            desc = "Git files";
          }
          {
            mode = "n";
            key = "<leader>e";
            action = "function() Snacks.explorer.open() end";
            lua = true;
            desc = "Explorer";
          }
          {
            mode = "n";
            key = "<leader>s";
            action = "function() Snacks.picker.lsp_symbols() end";
            lua = true;
            desc = "LSP symbols";
          }
          {
            mode = "n";
            key = "<leader>/";
            action = "function() Snacks.picker.grep() end";
            lua = true;
            desc = "Grep root dir";
          }
          {
            mode = "n";
            key = "<leader>um";
            action = "<cmd>RenderMarkdown toggle<cr>";
            desc = "Toggle markdown";
          }
          {
            mode = "n";
            key = "<leader>lR";
            action = ":LspRestart<CR>";
            desc = "Restart LSP";
          }
          {
            mode = "n";
            key = "<leader>cp";
            action = "<cmd>MarkdownPreviewToggle<cr>";
            desc = "Markdown preview";
          }
        ];

        extraPackages = with pkgs; [
          fd
          ripgrep
        ];
      };
    };
  };
}

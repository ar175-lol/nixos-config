{self, ...}: {
  users.ar175.home.base.home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  users.ar175.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myNvf];
  };

  perSystem = {pkgs, ...}: {
    myNvf.settings = {
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

      luaConfigRC.close-snacks-on-quit = ''
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
          end
        })
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
}

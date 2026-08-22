_: {
  nixos.modules.base = {pkgs, ...}: {
    programs.nixvim = {
      extraPackages = with pkgs; [
        alejandra
        fd
        gcc
        lua-language-server
        nixd
        ripgrep
        statix
        tree-sitter
        deadnix
      ];

      autoCmd = [
        {
          event = ["QuitPre"];
          callback.__raw = ''
            function()
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
          '';
        }
      ];
    };
  };
}

_: {
  nixos.modules.base = {pkgs, ...}: {
    programs.nixvim = {
      plugins = {
        gitsigns.enable = true;

        yanky = {
          enable = true;

          settings.highlight.on_yank = true;
        };

        todo-comments.enable = true;

        persistence = {
          enable = true;

          settings = {
            dir.__raw = ''vim.fn.stdpath("state") .. "/sessions/"'';

            options = [
              "buffers"
              "curdir"
              "tabpages"
              "winsize"
              "help"
            ];
          };
        };

        lazydev.enable = true;

        lsp-format.enable = true;

        lint = {
          enable = true;

          lintersByFt.nix = ["statix"];

          autoCmd = {
            event = ["BufWritePost" "BufReadPost" "InsertLeave"];
            callback.__raw = "function() require('lint').try_lint() end";
          };
        };

        cord.enable = true;
      };

      extraPlugins = [pkgs.vimPlugins.outline-nvim];

      extraConfigLua = ''
        require("outline").setup({})
      '';
    };
  };
}

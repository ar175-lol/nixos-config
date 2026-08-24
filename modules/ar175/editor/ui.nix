{
  nixos.modules.base = _: {
    programs.nvf.settings.vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      binds.whichKey = {
        enable = true;
        setupOpts.preset = "helix";
        register = {
          "<leader>c" = "code";
          "<leader>f" = "file/find";
          "<leader>q" = "quit/session";
          "<leader>s" = "search";
          "<leader>u" = "ui";
        };
      };

      statusline.lualine = {
        enable = true;
        theme = "auto";
        globalStatus = true;
        disabledFiletypes.statusline = ["snacks_dashboard"];
      };

      ui.noice = {
        enable = true;
        setupOpts.presets = {
          bottom_search = false;
          command_palette = true;
          long_message_to_split = true;
        };
      };

      utility.preview.markdownPreview.enable = true;

      languages.markdown.extensions.render-markdown-nvim.setupOpts = {
        html.enabled = false;
        code = {
          sign = false;
          width = "block";
          left_pad = 2;
          right_pad = 4;
        };
        heading.sign = false;
        checkbox.enabled = false;
        quote.repeat_linebreak = true;
        latex.enabled = false;
      };
    };
  };
}

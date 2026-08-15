_: {
  nixos.modules.base = _: {
    programs.nixvim = {
      colorschemes.tokyonight = {
        enable = true;
        settings = {
          style = "moon";
          styles = {
            comments = {italic = true;};
            keywords = {italic = true;};
            functions = {};
            variables = {};
            sidebars = "dark";
            floats = "dark";
          };
        };
      };

      plugins = {
        which-key = {
          enable = true;

          settings.preset = "helix";

          settings.spec = [
            {
              __unkeyed-1 = "<leader><tab>";
              group = "tabs";
            }
            {
              __unkeyed-1 = "<leader>c";
              group = "code";
            }
            {
              __unkeyed-1 = "<leader>d";
              group = "debug";
            }
            {
              __unkeyed-1 = "<leader>dp";
              group = "profiler";
            }
            {
              __unkeyed-1 = "<leader>f";
              group = "file/find";
            }
            {
              __unkeyed-1 = "<leader>g";
              group = "git";
            }
            {
              __unkeyed-1 = "<leader>gh";
              group = "hunks";
            }
            {
              __unkeyed-1 = "<leader>q";
              group = "quit/session";
            }
            {
              __unkeyed-1 = "<leader>s";
              group = "search";
            }
            {
              __unkeyed-1 = "<leader>u";
              group = "ui";
            }
            {
              __unkeyed-1 = "<leader>x";
              group = "diagnostics/quickfix";
            }
            {
              __unkeyed-1 = "[";
              group = "prev";
            }
            {
              __unkeyed-1 = "]";
              group = "next";
            }
            {
              __unkeyed-1 = "g";
              group = "goto";
            }
            {
              __unkeyed-1 = "gs";
              group = "surround";
            }
            {
              __unkeyed-1 = "z";
              group = "fold";
            }
          ];
        };

        lualine = {
          enable = true;

          settings.options = {
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

        noice = {
          enable = true;

          settings = {
            cmdline = {
              enabled = true;
              view = "cmdline_popup";
            };
            messages.enabled = true;
            popupmenu.enabled = true;
            presets = {
              bottom_search = false;
              command_palette = true;
              long_message_to_split = true;
            };
          };
        };

        render-markdown = {
          enable = true;

          settings = {
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
        };

        markdown-preview = {
          enable = true;
          settings.auto_start = 0;
        };
      };
    };
  };
}

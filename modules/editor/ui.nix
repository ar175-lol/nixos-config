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

          settings = {
            options = {
              theme = "tokyonight";
              globalstatus = true;
              disabled_filetypes.statusline = ["snacks_dashboard"];
            };

            sections = {
              lualine_a = ["mode"];
              lualine_b = ["branch"];

              lualine_c = [
                {
                  __unkeyed-1.__raw = ''
                    function()
                      local root = vim.fs.root(0, ".git") or vim.uv.cwd()
                      return "󱉭 " .. vim.fs.basename(root)
                    end
                  '';
                  color.__raw = ''function() return { fg = Snacks.util.color("Special") } end'';
                }
                {
                  __unkeyed-1 = "diagnostics";
                  symbols = {
                    error = " ";
                    warn = " ";
                    info = " ";
                    hint = " ";
                  };
                }
                {
                  __unkeyed-1 = "filetype";
                  icon_only = true;
                  separator = "";
                  padding = {
                    left = 1;
                    right = 0;
                  };
                }
                {
                  __unkeyed-1.__raw = ''
                    function()
                      local bufname = vim.api.nvim_buf_get_name(0)
                      if bufname == "" then
                        return "[No Name]"
                      end
                      local root = vim.fs.root(0, ".git") or vim.uv.cwd()
                      local path = vim.fs.relpath(root, bufname) or vim.fn.fnamemodify(bufname, ":~:.")
                      if vim.bo.modified then
                        path = path .. " ●"
                      end
                      if vim.bo.readonly then
                        path = path .. " 󰌾"
                      end
                      return path
                    end
                  '';
                }
              ];

              lualine_x = [
                {
                  __unkeyed-1.__raw = ''function() return require("noice").api.status.command.get() end'';
                  cond.__raw = ''function() return require("noice").api.status.command.has() end'';
                  color.__raw = ''function() return { fg = Snacks.util.color("Statement") } end'';
                }
                {
                  __unkeyed-1.__raw = ''function() return require("noice").api.status.mode.get() end'';
                  cond.__raw = ''function() return require("noice").api.status.mode.has() end'';
                  color.__raw = ''function() return { fg = Snacks.util.color("Constant") } end'';
                }
                {
                  __unkeyed-1 = "diff";
                  symbols = {
                    added = " ";
                    modified = " ";
                    removed = " ";
                  };
                  source.__raw = ''
                    function()
                      local gitsigns = vim.b.gitsigns_status_dict
                      if gitsigns then
                        return {
                          added = gitsigns.added,
                          modified = gitsigns.changed,
                          removed = gitsigns.removed,
                        }
                      end
                    end
                  '';
                }
              ];

              lualine_y = ["progress" "location"];

              lualine_z = [
                {
                  __unkeyed-1.__raw = ''
                    function()
                      return " " .. os.date("%R")
                    end
                  '';
                }
              ];
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

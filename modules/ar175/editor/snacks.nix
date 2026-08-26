let
  flakePath = "/home/ar175/nixos-config";
in {
  perSystem = {lib, ...}: {
    myNvf.settings.utility.snacks-nvim = {
      enable = true;

      setupOpts = {
        input.enabled = false;

        dashboard = {
          enabled = true;
          width = 36;

          preset.keys = [
            {
              icon = " ";
              key = "f";
              desc = "Find File";
              action = "<Cmd>lua Snacks.dashboard.pick('files')<CR>";
            }
            {
              icon = " ";
              key = "n";
              desc = "New File";
              action = "<Cmd>ene | startinsert<CR>";
            }
            {
              icon = " ";
              key = "g";
              desc = "Find Text";
              action = "<Cmd>lua Snacks.dashboard.pick('live_grep')<CR>";
            }
            {
              icon = " ";
              key = "r";
              desc = "Recent Files";
              action = "<Cmd>lua Snacks.dashboard.pick('oldfiles')<CR>";
            }
            {
              icon = "";
              key = "c";
              desc = "Config";
              action = "<Cmd>lua Snacks.explorer.open({ cwd = '${flakePath}' })<CR>";
            }
            {
              icon = " ";
              key = "s";
              desc = "Restore Session";
              action = "<Cmd>lua require('persisted').load()<CR>";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = "<Cmd>qa<CR>";
            }
          ];

          formats = {
            key = lib.mkLuaInline "function(item) return { { \"[\", hl = \"special\" }, { item.key, hl = \"key\" }, { \"]\", hl = \"special\" } } end";
            header = lib.mkLuaInline "{ \"%s\", hl = \"SnacksIndent6\" }";
          };

          sections = [
            {padding = 1;}
            {section = "header";}
            {
              icon = " ";
              title = "Keymaps";
              section = "keys";
              indent = 2;
              padding = 1;
            }
            {
              icon = " ";
              title = "Recent Files";
              section = "recent_files";
              indent = 2;
              padding = 1;
            }
            {
              icon = " ";
              title = "Projects";
              section = "projects";
              indent = 2;
              padding = 1;
            }
          ];
        };

        picker = {
          enabled = true;
          ui_select = true;
        };
        explorer = {
          enabled = true;
          trash = false;
        };
        indent.enabled = true;
        rename.enabled = true;
        words.enabled = true;
        image.enabled = false;
        notifier.enabled = true;
        lazygit.enabled = false;
      };
    };
  };
}

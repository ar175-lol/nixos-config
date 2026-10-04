_: {
  users.ar175.home.gui = {pkgs, ...}: {
    home.packages = [
      # LSPs
      pkgs.nixd
      pkgs.gopls

      # Formatters & Linters
      pkgs.alejandra
      pkgs.deadnix
      pkgs.statix
    ];

    programs.zed-editor = {
      enable = true;

      extensions = [
        # Theme
        "catppuccin"
        "catppuccin-icons"
        # Languages
        "git-firefly"
        "nix"
        "toml"
      ];

      userSettings = {
        indent_guides = {
          background_coloring = "disabled";
        };

        lsp = {
          nixd = {
            initialization_options = {
              formatting.command = ["alejandra"];

              options = {
                nixos = {
                  expr = "(builtins.getFlake \"/home/ar175/nixos-config\").nixosConfigurations.victus.options";
                };
                home-manager = {
                  expr = "(builtins.getFlake \"/home/ar175/nixos-config\").nixosConfigurations.victus.options.home-manager.users.type.getSubOptions []";
                };
                flake-parts = {
                  expr = "(builtins.getFlake \"/home/ar175/nixos-config\").debug.options";
                };
                flake-parts-per-system = {
                  expr = "(builtins.getFlake \"/home/ar175/nixos-config\").currentSystem.options";
                };
              };
              nixpkgs = {
                expr = "import (builtins.getFlake \"/home/ar175/nixos-config\").inputs.nixpkgs { }";
              };
            };
          };
        };

        languages = {
          "Nix" = {
            language_servers = ["nixd"];
            format_on_save = "on";
          };
        };

        git.disable_git = false;

        disable_ai = true;

        vim = {
          cursor_shape.insert = "bar";
          use_system_clipboard = "on_yank";
        };

        which_key = {
          delay_ms = 300;
          enabled = true;
        };

        text_rendering_mode = "subpixel";
        buffer_line_height = "comfortable";
        auto_update = false;

        telemetry = {
          diagnostics = false;
          metrics = false;
          anthropic_retention = false;
        };

        tab_bar.show = false;

        project_panel = {
          dock = "left";
          file_icons = true;
        };

        ui_font_family = "JetBrainsMono Nerd Font";
        buffer_font_family = "JetBrainsMono Nerd Font";
        icon_theme = "Catppuccin Mocha";

        session.trust_all_worktrees = true;

        vim_mode = true;
        ui_font_size = 16;
        buffer_font_size = 15;

        theme = {
          mode = "dark";
          dark = "Catppuccin Mocha";
        };

        "experimental.theme_overrides" = {
          "editor.indent_guide" = "#45475a";
          "editor.indent_guide_active" = "#cba6f7";
        };
      };

      userKeymaps = [
        {
          context = "Editor";
          bindings = {
            "ctrl-shift-v" = "editor::Paste";
          };
        }
        {
          context = "ProjectPanel";
          bindings = {
            "A" = "project_panel::NewFile";
            "D" = "project_panel::NewDirectory";
          };
        }
      ];
    };
  };
}

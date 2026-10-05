_: {
  users.ar175.home.gui = {pkgs, ...}: {
    home.packages = [
      # LSPs
      pkgs.nixdPatched
      pkgs.gopls
      pkgs.markdownlint-cli

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
        "markdownlint"
      ];

      userSettings = {
        indent_guides = {
          background_coloring = "disabled";
        };

        lsp = {
          nixd = {
            initialization_options = {
              formatting.command = ["alejandra"];

              # NOTE: "nixos" and "nixpkgs" are deliberately omitted.
              #
              # nixd unconditionally starts a "nixos" options worker and a
              # "nixpkgs" worker using its built-in defaults
              # (import <nixpkgs> {}), and only overrides them if we supply an
              # expr here. Measured over 71 completion positions across this
              # config, the defaults returned byte-identical results to
              # evaluating our flake, while skipping two `builtins.getFlake`
              # evaluations (~2.4s each) on every editor start -- one less way
              # for a dirty tree or an eval hiccup to silently kill all NixOS
              # completions.
              #
              # home-manager and flake-parts options cannot be derived from
              # nixpkgs, so those still have to come from the flake.
              options = {
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
            "D" = "project_panel::Delete";
          };
        }
      ];
    };
  };
}

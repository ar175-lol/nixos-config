{inputs, ...}: {
  nixpkgs.overlays = [
    (
      final: _: {
        myTerminal = inputs.wrapper-modules.wrappers.kitty.wrap {
          inherit (final) pkgs;

          font = {
            # name = "JetBrainsMono Nerd Font";
            name = "Monocraft";
            size = 15;
          };

          settings = {
            window_padding_width = 0;
            window_margin_width = 0;
            hide_window_decorations = "yes";
            tab_bar_style = "hidden";
            adjust_line_height = 6;

            confirm_os_window_close = 0;

            cursor_shape = "block";
            cursor_blink_interval = 1;
            scrollback_lines = 10000;

            cursor_trail = 12;
            # cursor_trail_decay = "0.05 0.15";

            enable_audio_bell = "no";
            window_alert_on_bell = "no";

            repaint_delay = 10;
            input_delay = 3;
            sync_to_monitor = "yes";

            foreground = "#CDD6F4";
            background = "#1E1E2E";
            selection_foreground = "#1E1E2E";
            selection_background = "#F5E0DC";

            cursor = "#F5E0DC";
            cursor_text_color = "#1E1E2E";
            url_color = "#F5E0DC";

            color0 = "#45475A";
            color8 = "#585B70";
            color1 = "#F38BA8";
            color9 = "#F38BA8";
            color2 = "#A6E3A1";
            color10 = "#A6E3A1";
            color3 = "#F9E2AF";
            color11 = "#F9E2AF";
            color4 = "#89B4FA";
            color12 = "#89B4FA";
            color5 = "#F5C2E7";
            color13 = "#F5C2E7";
            color6 = "#94E2D5";
            color14 = "#94E2D5";
            color7 = "#BAC2DE";
            color15 = "#A6ADC8";
          };

          keybindings = {
            "ctrl+shift+c" = "copy_to_clipboard";
            "ctrl+shift+v" = "paste_from_clipboard";
            "ctrl+shift+s" = "paste_from_selection";
            "ctrl+shift+equal" = "change_font_size all +2.0";
            "ctrl+shift+minus" = "change_font_size all -2.0";
            "ctrl+shift+backspace" = "change_font_size all 0";
          };
        };

        myYazi = inputs.wrapper-modules.wrappers.yazi.wrap {
          inherit (final) pkgs;
          settings.yazi.mgr = {
            sort_sensitive = false;
            sort_by = "none";
            sort_dir_first = true;
            show_hidden = true;
            show_symlink = true;
          };
        };

        myTmux = let
          bindWindowSelect = n: "bind -n M-${n} select-window -t ${n}";
        in
          inputs.wrapper-modules.wrappers.tmux.wrap {
            inherit (final) pkgs;

            prefix = "C-a";
            terminal = "tmux-256color";
            mouse = true;
            escapeTime = 10;
            baseIndex = 1;
            modeKeys = "vi";
            vimVisualKeys = true;

            plugins = [
              {
                plugin = inputs.catppuccin.packages.${final.stdenv.hostPlatform.system}.tmux;

                configBefore = ''
                  set -g @catppuccin_flavor "mocha"
                  set -g @catppuccin_window_status_style "rounded"
                '';
              }
            ];

            configBefore = ''
              set -as terminal-overrides ',*:Tc'
              set -as terminal-overrides ',*:RGB'
              set -as terminal-overrides ',*:Smulx=\E[4\:%p1%dm'
              set -as terminal-overrides ',*:Setulc=\E[58\:2\:\:%p1%{65536}%/%d\:%p1%{256}%/%{255}%&%d\:%p1%{255}%&%d%;m'

              set -s set-clipboard on
              unbind -T copy-mode-vi MouseDragEnd1Pane
              unbind -T copy-mode MouseDragEnd1Pane

              set -g renumber-windows on

              unbind r

              bind -n M-c new-window -c "#{pane_current_path}"
              bind -n M-x kill-window

              ${builtins.concatStringsSep "\n" (map bindWindowSelect (builtins.genList (n: toString (n + 1)) 9))}

              bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle

              set -g status "on"
              set -g status-justify "left"
              set -g status-left-length "100"
              set -g status-right-length "100"
              set -g window-status-separator ""
            '';

            configAfter = ''
              set -g status-left ""
              set -g status-right "#{E:@catppuccin_status_application}"
              set -agF status-right "#{E:@catppuccin_status_session}"
              set -agF status-right "#{E:@catppuccin_status_date_time}"

              set -g clock-mode-colour "#89b4fa"
              set -g mode-style "fg=#89b4fa,bg=#585b70,bold"
            '';
          };
      }
    )
  ];
}

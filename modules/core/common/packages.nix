{inputs, ...}: {
  nixpkgs.overlays = [
    (
      final: _: {
        myTerminal = inputs.wrapper-modules.wrappers.foot.wrap {
          inherit (final) pkgs;
          settings = {
            main = {
              font = "JetBrainsMono Nerd Font:size=12.4";
              pad = "0x0 center color=1e1e2e";
            };
            scrollback.lines = 10000;
            bell = {
              urgent = "no";
              notify = "no";
            };
            cursor = {
              style = "beam";
              blink = "yes";
            };
            colors-dark = {
              background = "1e1e2e";
              foreground = "cdd6f4";
              regular0 = "45475a";
              regular1 = "f38ba8";
              regular2 = "a6e3a1";
              regular3 = "f9e2af";
              regular4 = "89b4fa";
              regular5 = "f5c2e7";
              regular6 = "94e2d5";
              regular7 = "a6adc8";
              bright0 = "585b70";
              bright1 = "f37799";
              bright2 = "89d88b";
              bright3 = "ebd391";
              bright4 = "74a8fc";
              bright5 = "f2aede";
              bright6 = "6bd7ca";
              bright7 = "bac2de";
              selection-foreground = "cdd6f4";
              selection-background = "585b70";
              cursor = "1e1e2e f5e0dc";
            };
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
              bind r source-file "${placeholder "out"}/tmux.conf"

              bind -n M-c new-window -c "#{pane_current_path}"
              bind -n M-x kill-window

              ${builtins.concatStringsSep "\n" (map bindWindowSelect (builtins.genList (n: toString (n + 1)) 9))}

              bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle

              set -g status "on"
              set -g status-style "bg=#1e1e2e"
              set -g status-justify "left"
              set -g status-left-length "100"
              set -g status-right-length "100"

              set -g message-style "fg=#89dceb,bg=#313244,align=centre"

              set -g window-status-activity-style "fg=#cdd6f4,bg=#1e1e2e,none"
              set -g window-status-separator ""
              set -g window-status-style "fg=#a6adc8,bg=#1e1e2e,none"

              set -g window-status-current-format "#[fg=#89b4fa,bg=#1e1e2e] #I: #[fg=#cba6f7,bg=#1e1e2e](✓) #[fg=#89dceb,bg=#1e1e2e]#(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) #[fg=#cba6f7,bg=#1e1e2e]"
              set -g window-status-format "#[fg=#89b4fa,bg=#1e1e2e] #I: #[fg=#cdd6f4,bg=#1e1e2e]#W"

              set -g status-right "#[fg=#89b4fa,bg=#1e1e2e,nobold,nounderscore,noitalics]#[fg=#1e1e2e,bg=#89b4fa,nobold,nounderscore,noitalics] #[fg=#cdd6f4,bg=#313244] #W #{?client_prefix,#[fg=#cba6f7],#[fg=#89dceb]}#[bg=#313244]#{?client_prefix,#[bg=#cba6f7],#[bg=#89dceb]}#[fg=#1e1e2e] #[fg=#cdd6f4,bg=#313244] #S "
              set -g status-left ""

              set -g clock-mode-colour "#89b4fa"
              set -g mode-style "fg=#89b4fa,bg=#585b70,bold"
            '';
          };
      }
    )
  ];
}

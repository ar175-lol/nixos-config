{
  inputs,
  self,
  ...
}: let
  bindWindowSelect = n: "bind -n M-${n} select-window -t ${n}";
in {
  perSystem = {pkgs, ...}: {
    packages.myTmux = inputs.wrapper-modules.wrappers.tmux.wrap {
      inherit pkgs;

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
        set -g status-style "bg=#222436"
        set -g status-justify "left"
        set -g status-left-length "100"
        set -g status-right-length "100"

        set -g message-style "fg=#86e1fc,bg=#3a3f5a,align=centre"

        set -g window-status-activity-style "fg=#c8d3f5,bg=#222436,none"
        set -g window-status-separator ""
        set -g window-status-style "fg=#c8d3f5,bg=#222436,none"

        set -g window-status-current-format "#[fg=#82aaff,bg=#222436] #I: #[fg=#c099ff,bg=#222436](✓) #[fg=#86e1fc,bg=#222436]#(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) #[fg=#c099ff,bg=#222436]"
        set -g window-status-format "#[fg=#82aaff,bg=#222436] #I: #[fg=#c8d3f5,bg=#222436]#W"

        set -g status-right "#[fg=#82aaff,bg=#222436,nobold,nounderscore,noitalics]#[fg=#222436,bg=#82aaff,nobold,nounderscore,noitalics] #[fg=#c8d3f5,bg=#3a3f5a] #W #{?client_prefix,#[fg=#c099ff],#[fg=#86e1fc]}#[bg=#3a3f5a]#{?client_prefix,#[bg=#c099ff],#[bg=#86e1fc]}#[fg=#222436] #[fg=#c8d3f5,bg=#3a3f5a] #S "
        set -g status-left ""

        set -g clock-mode-colour "#82aaff"
        set -g mode-style "fg=#82aaff,bg=#444a73,bold"
      '';
    };
  };

  users.ar175.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myTmux];
  };
}

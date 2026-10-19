{pkgs, ...}: let
  home = {
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;

      autosuggestion = {
        enable = true;
        strategy = [
          "history"
          "completion"
        ];
      };

      history = {
        size = 101;
        ignoreAllDups = true;
        ignoreSpace = true;
      };

      historySubstringSearch = {
        enable = true;
        searchUpKey = "^[[A";
        searchDownKey = "^[[B";
      };

      shellAliases = {
        sync = "cp ~/.local/state/noctalia/settings.toml ~/nixos-config/modules/system/programs/noctalia.toml && nix run .#write-flake && nix fmt . && git add . && nh os switch"; # Oh no, hardcoding!!! TODO: fix these hardcodes
        update = "git add . && nix flake update && git add . && sync";
      };

      initContent = ''
        eval "$(starship init zsh)"

        autoload -Uz compinit && compinit -C
        export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=25
        export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

        bindkey -v
        export KEYTIMEOUT=25

        bindkey '^H' backward-kill-word
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word
        bindkey -M viins '^ ' autosuggest-accept
        bindkey -M vicmd '^ ' autosuggest-accept

        accept-line() {
          {
            unfunction _al_f_
            functions[_al_f_]=$BUFFER
          } 2> /dev/null
          if (( $+functions[_al_f_] )); then
            zle .$WIDGET
          else
            zle -M "Command unfinished or invalid."
          fi
        }
        zle -N accept-line
      '';
    };

    programs.yazi = {
      enable = true;
      package = pkgs.myYazi;
    };
  };
in {
  config = {
    programs.zsh.enable = true;

    home-manager.sharedModules = [home];
  };
}

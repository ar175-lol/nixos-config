_: let
  zsh = shellAliases: {
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;

      autosuggestion = {
        enable = true;
        strategy = ["history" "completion"];
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

      inherit shellAliases;

      initContent = ''
        autoload -Uz compinit && compinit -C
        export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=25
        export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

        bindkey '^H' backward-kill-word
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word

        accept-line() {
          {
            unfunction _al_f_
            functions[_al_f_]=$BUFFER
          } 2> /dev/null
          if (( $+functions[_al_f_] )); then
            zle .$WIDGET
          else
            zle beep
            zle -M "Command unfinished or invalid."
          fi
        }
        zle -N accept-line
      '';
    };
  };
in {
  homeManager.ar175 = zsh {
    sync = "nix run .#write-flake && git add . && nh os switch";
    update = "nix run .#write-flake && git add . && nh os switch --update";
    clean = "nh clean all";
  };

  homeManager.kirk = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };
  };
}

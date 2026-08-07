{config, ...}: {
  nixos = {
    shell = "zsh";

    base = {pkgs, ...}: {
      programs.zsh.enable = config.nixos.shell == "zsh";
      programs.fish.enable = config.nixos.shell == "fish";

      users.users.ar175.shell = pkgs.${config.nixos.shell};
    };
  };
  homeManager.ar175 = {shell, ...}: {
    programs = {
      zsh = {
        enable = shell == "zsh";
        syntaxHighlighting.enable = true;

        autosuggestion = {
          enable = true;
          strategy = ["history" "completion"];
        };

        history = {
          size = 101;
          ignoreAllDups = true;
          ignoreSpace = true;
          ignorePatterns = ["* rm *" "* pkill *" "* cat *" "* grep *" "* cd *" "direnv *" "* journalctl *" "* ls *" "/*"];
        };

        historySubstringSearch = {
          enable = true;
          searchUpKey = "^[[A";
          searchDownKey = "^[[B";
        };

        shellAliases = {
          nxr = "git add . && nh os switch";
          nxru = "git add . && nh os switch --update";
          ncg = "nh clean all";
        };

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

      # ===========================================================================

      fish = {
        enable = shell == "fish";

        shellAbbrs = {
          nxr = "git add . && nh os switch";
          uxru = "git add . && nh os switch --update";
        };

        interactiveShellInit = ''
          set fish_greeting
        '';
      };
    };
  };
}

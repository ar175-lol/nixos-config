_: {
  users.ar175.nixos.base = {pkgs, ...}: {
    users.users.ar175 = {
      shell = pkgs.zsh;
      hashedPassword = "$6$4ObEABrHkyfFS35K$DkgMD.MLEY7N0FQehWWlJBvrFlmZS9kX3cNQ1L6Gok0VAsMFrRhdX1PoBgV7uC0NFzmzyZAQ2u6PW4jPSZV5M.";
      description = "ar175";
      extraGroups = ["wheel" "video" "audio" "input" "adbusers"];
    };

    programs.zsh.enable = true;
  };

  users.ar175.home.base = {
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

      shellAliases = {
        sync = "git add . && nix run .#write-flake && git add . && nh os switch";
        update = "git add . && nix run .#write-flake && git add . && nh os switch --update";
        clean = "nh clean all";
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
  };
}

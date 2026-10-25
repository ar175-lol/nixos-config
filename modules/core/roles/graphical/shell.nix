{pkgs, ...}: let
  noctaliaSync = pkgs.writeShellApplication {
    name = "noctalia-sync";
    runtimeInputs = [pkgs.gnused pkgs.git pkgs.nh];

    text = ''
      set -euo pipefail

      repo="$HOME/nixos-config"
      settings="$HOME/.local/state/noctalia/settings.toml"
      config="$repo/modules/system/programs/noctalia/config.toml"

      sed -E \
        -e 's|@DATA@|@ASSETS@|g' \
        -e "s|$HOME/nixos-config/data|@ASSETS@|g" \
        -e "s|$HOME/nixos-config/modules/system/programs/noctalia/assets|@ASSETS@|g" \
        -e 's|/nix/store/[[:alnum:]]+-assets|@ASSETS@|g' \
        "$settings" > "$config"

      git -C "$repo" add "$repo"
      cd "$repo"
      nh os switch
    '';
  };

  home = {
    home.packages = [noctaliaSync];

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
        sync = "noctalia-sync";
        update = "git add . && nix flake update && git add . && sync";
      };

      initContent = ''
        autoload -Uz compinit && compinit -C
        export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=25 export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
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

    # TODO: move this to different file
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

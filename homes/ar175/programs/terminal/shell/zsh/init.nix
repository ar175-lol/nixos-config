_: {
  programs.zsh.initContent = ''
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
}

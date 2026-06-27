_: {
  nixos.home = {pkgs, ...}: {
    home.packages = [pkgs.fastfetch];

    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        autosuggestion = {
          enable = true;
          strategy = ["history" "completion"];
        };

        history = {
          size = 750;
          ignoreAllDups = true;
          ignoreSpace = true;
        };

        historySubstringSearch = {
          enable = true;
          searchUpKey = "^[[A";
          searchDownKey = "^[[B";
        };

        zsh-abbr = {
          enable = true;
          abbreviations = {
            update = "git add . && nh os switch";
            upgrade = "git add . && nix flake update && nh os switch";
            ncg = "nh clean all";
          };
        };

        initContent = ''
          echo -ne '\e[5 q'

          bindkey '^H' backward-kill-word
          bindkey "^[[1;5D" backward-word
          bindkey "^[[1;5C" forward-word
        '';
      };

      nix-index = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}

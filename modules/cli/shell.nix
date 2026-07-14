{config, ...}: {
  nixos = {
    shell = "zsh";

    base = {pkgs, ...}: {
      programs.zsh.enable = config.nixos.shell == "zsh";
      programs.fish.enable = config.nixos.shell == "fish";

      users.users.ar175.shell = pkgs.${config.nixos.shell};
    };

    home = {
      shell,
      pkgs,
      ...
    }: {
      home.packages = [pkgs.fastfetch];

      programs = {
        zsh = {
          enable = shell == "zsh";
          syntaxHighlighting.enable = true;

          autosuggestion = {
            enable = true;
            strategy = ["history" "completion"];
          };

          history = {
            size = 500;
            ignoreAllDups = true;
            ignoreSpace = true;
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
          '';
        };

        nix-index = {
          enable = true;
          enableFishIntegration = shell == "fish";
          enableZshIntegration = shell == "zsh";
        };

        # ===========================================================================

        fish = {
          enable = shell == "fish";

          shellAbbrs = {
            nos = "git add . && nh os switch";
            unos = "git add . && nh os switch --update";
          };

          interactiveShellInit = ''
            set fish_greeting
          '';
        };
      };
    };
  };
}

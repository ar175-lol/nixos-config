{...}: {
  flake.homeModules.myZsh = {pkgs, ...}: {
    home.packages = [pkgs.fastfetch];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      autosuggestion = {
        enable = true;
        strategy = ["history" "completion"];
      };

      historySubstringSearch = {
        enable = true;
        searchUpKey = "^[[A";
        searchDownKey = "^[[B";
      };

      initContent = ''
        echo -ne '\e[5 q'

        alias update="git add . && sudo nixos-rebuild switch --flake .#victus"
        alias upgrade="git add . && nix flake update && sudo nixos-rebuild switch --flake .#victus"
        alias ncg="nix-collect-garbage -d"
      '';
    };
    programs.nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

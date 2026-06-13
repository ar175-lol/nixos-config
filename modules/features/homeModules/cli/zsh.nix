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

      shellAliases = {
        update = "git add . && sudo nixos-rebuild switch --flake .#victus";
        upgrade = "git add . && nix flake update && sudo nixos-rebuild --flake .#victus";
        ncg = "nix-collect-garbage -d";
      };

      initExtra = ''
        echo -ne '\e[5 q'
      '';
    };
  };
}

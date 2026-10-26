_: {
  imports = [
    ./init.nix
    ./aliases.nix
  ];
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

    dirHashes = {
      docs = "$HOME/Documents";
      dl = "$HOME/Downloads";
      vids = "$HOME/Videos";
    };

    history = {
      size = 100;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      ignorePatterns = ["rm *" "cd *"];
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = "^[[A";
      searchDownKey = "^[[B";
    };
  };
}

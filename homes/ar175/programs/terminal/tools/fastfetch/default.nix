_: {
  programs.fastfetch = {
    enable = true;
    # https://www.reddit.com/r/GarudaLinux/comments/1dcq0dl/making_fastfetch_more_beautiful/
    settings = builtins.fromJSON (builtins.readFile ./config.jsonc);
  };
}

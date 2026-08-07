_: {
  homeManager.ar175 = {
    pkgs,
    config,
    ...
  }: {
    home.packages = [pkgs.tmux];

    home.file.".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dots/tmux";
  };
}

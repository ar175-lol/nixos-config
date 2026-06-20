_: {
  nixos.home = {
    programs.obsidian = {
      enable = true;
      vaults = {
        main = {
          enable = true;
        };
      };
    };
  };
}

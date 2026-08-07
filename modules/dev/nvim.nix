_: {
  nixos.base = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [statix ripgrep nixd gcc lua-language-server rust-analyzer neovim tree-sitter alejandra];
  };
  homeManager.ar175 = {config, ...}: {
    home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dots/nvim";

    xdg.mimeApps.defaultApplications = {
      "text/plain" = ["nvim.desktop"];
    };
  };
}

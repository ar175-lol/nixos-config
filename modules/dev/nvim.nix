_: {
  nixos.base = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [statix ripgrep nixd gcc lua-language-server rust-analyzer neovim tree-sitter alejandra];
  };
  nixos.home = {config, ...}: {
    home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/ar175/nixos-config/modules/dev/nvim";
  };
}

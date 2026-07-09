{pkgs, ...}: {
  nixos.base = _: {
    environment.systemPackages = with pkgs; [nixd gcc lua-language-server rust-analyzer neovim tree-sitter alejandra];
  };
  nixos.home = {
    xdg.configFile."nvim".source = ./_nvim;
  };
}

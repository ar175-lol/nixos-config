_: {
  nixOnDroid.modules.base = {pkgs, ...}: {
    environment.packages = with pkgs; [
      git
      neovim
    ];
  };
}
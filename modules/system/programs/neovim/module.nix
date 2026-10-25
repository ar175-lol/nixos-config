{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.neovim;
  settings = import ./_settings.nix {inherit lib pkgs;};
in {
  imports = [inputs.nvf.nixosModules.default];

  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      settings.vim = settings;
    };
  };
}

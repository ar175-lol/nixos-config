{inputs, ...}: {
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim";

  nixos.modules.base = {...}: {
    imports = [inputs.nixvim.nixosModules.nixvim];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}

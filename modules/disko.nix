{inputs, ...}: {
  flake-file.inputs.disko.url = "github:nix-community/disko";

  nixos.modules.base = {
    imports = [inputs.disko.nixosModules.disko];
  };
}

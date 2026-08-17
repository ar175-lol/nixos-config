{inputs, ...}: {
  flake-file.inputs.lix-module = {
    url = "git+https://git.lix.systems/lix-project/nixos-module";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  nixos.modules.base = {
    imports = [inputs.lix-module.nixosModules.default];
    lix.enable = true;
  };
}

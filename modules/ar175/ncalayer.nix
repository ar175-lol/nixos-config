{inputs, ...}: {
  flake-file.inputs.ncalayer = {
    url = "github:ar175-lol/ncalayer-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  users.ar175.nixos.pc = {
    imports = [inputs.ncalayer.nixosModules.default];
    services.ncalayer.enable = true;
  };
}

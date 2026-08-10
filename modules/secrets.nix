{inputs, ...}: {
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  nixos.base = {pkgs, ...}: {
    imports = [inputs.sops-nix.nixosModules.sops];

    environment.systemPackages = with pkgs; [
      sops
      age
    ];

    sops = {
      defaultSopsFile = ../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
    };
  };

  homeManager.ar175 = {inputs, ...}: {
    imports = [inputs.sops-nix.homeManagerModules.sops];
  };

  homeManager.kirk = {inputs, ...}: {
    imports = [inputs.sops-nix.homeManagerModules.sops];
  };
}

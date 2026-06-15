{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.my-iso = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
      config.nixos.my-iso
    ];
  };
}

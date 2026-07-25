{
  config,
  inputs,
  ...
}: {
  nixos.configurations.iso = {
    modules = [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix"

      config.nixos.iso
      inputs.home-manager.nixosModules.default

      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit inputs;
          };
          backupFileExtension = "backup";
          users.nixos = config.homeManager.nixos;
        };
      }
    ];
  };
}

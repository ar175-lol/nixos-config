{
  config,
  inputs,
  ...
}: {
  nixos.configurations.iso.modules = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix"

    config.nixos.modules.base
    config.users.nixos.nixos.base

    {
      nixpkgs.hostPlatform = "x86_64-linux";
      home-manager.backupFileExtension = "backup";
    }
  ];
}

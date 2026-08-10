_: {
  nixos.kirk = {
    lib,
    modulesPath,
    ...
  }: {
    imports = [(modulesPath + "/installer/scan/not-detected.nix")];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/00000000-0000-0000-0000-000000000000";
      fsType = "ext4";
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}

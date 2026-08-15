# Lorem ipsum dolor sit amet consectetur adipiscing elit.
# Quisque faucibus ex sapien vitae pellentesque sem placerat.
# In id cursus mi pretium tellus duis convallis.
# Tempus leo eu aenean sed diam urna tempor.
# Pulvinar vivamus fringilla lacus nec metus bibendum egestas.
# Iaculis massa nisl malesuada lacinia integer nunc posuere.
# Ut hendrerit semper vel class aptent taciti sociosqu.
# Ad litora torquent per conubia nostra inceptos himenaeos.
# Just a stub, idk sakjflksjdfkasjdfka
_: {
  users.kirk.nixos.pc = {
    lib,
    modulesPath,
    ...
  }: {
    imports = [(modulesPath + "/installer/scan/not-detected.nix")];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/00000000-0000-0000-0000-000000000000";
      fsType = "ext4";
    };
    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/1E13-C416B";
      fsType = "vfat";
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}

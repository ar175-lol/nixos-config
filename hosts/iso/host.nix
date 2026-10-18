{inputs, ...}: {
  hosts.iso = {
    enable = true;
    hostName = "nixos";
    stateVersion = "26.05";

    users.nixos = {
      description = "installer";
      shell = "fish";
    };

    roles = ["iso"];

    features = {
      modules.system.programs.niri.enable = true;
    };

    extraModules = [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix"
    ];
  };
}

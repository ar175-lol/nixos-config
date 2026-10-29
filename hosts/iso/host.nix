{inputs, ...}: {
  hosts.iso = {
    enable = true;
    hostName = "nixos";
    stateVersion = "26.05";

    users.nixos = {
      description = "installer";
      shell = "fish";
    };

    roles = ["graphical"];

    features = {
      modules.system.programs = {
        greeter.enable = false;
        neovim.enable = true;
      };
    };

    extraModules = [
      ./live.nix
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix"
    ];
  };
}

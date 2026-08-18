{inputs, ...}: {
  flake-file.inputs.nix-flatpak = {
    url = "github:gmodena/nix-flatpak/?ref=latest";
  };
  users.ar175.nixos.pc = {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
    services.flatpak = {
      enable = true;
      packages = ["org.vinegarhq.Sober"];
    };
  };
}

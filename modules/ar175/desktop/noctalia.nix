{self, ...}: {
  flake-file.inputs.noctalia.url = "github:noctalia-dev/noctalia/cachix";

  users.ar175.nixos.pc = {pkgs, ...}: {
    services.upower.enable = true;

    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
    ];

    nix.settings = {
      extra-substituters = ["https://noctalia.cachix.org"];
      extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
    };
  };
}

{inputs, ...}: {
  flake-file.inputs.noctalia.url = "github:noctalia-dev/noctalia/cachix";

  users.ar175.nixos.pc = {pkgs, ...}: {
    nix.settings = {
      substituters = ["https://noctalia.cachix.org"];
      trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
    };
    environment.systemPackages = [pkgs.wl-clipboard];
  };

  perSystem = {pkgs, ...}: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;

      package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

      enableDumpScript = false;

      constructFiles.config-toml = {
        key = "configToml";
        relPath = "noctalia-config/config.toml";
        output = "out";
        content = builtins.readFile ./noctalia.toml;
      };

      env.NOCTALIA_CONFIG_HOME = "${placeholder "out"}/noctalia-config/";
    };
  };
}

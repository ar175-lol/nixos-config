#
{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.noctalia;

  dataDir = ../../../data;

  # For VM: noctalia should have my config, my wallpapers, or I am gonna cry
  noctaliaToml = lib.replaceStrings ["@DATA@"] ["${dataDir}"] (builtins.readFile ./noctalia.toml);
in {
  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      (
        final: _: {
          myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
            inherit (final) pkgs;

            package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

            enableDumpScript = false;

            constructFiles.config-toml = {
              key = "configToml";
              relPath = "noctalia-config/noctalia/config.toml";
              output = "out";
              content = noctaliaToml;
            };

            env.NOCTALIA_CONFIG_HOME = "${placeholder "out"}/noctalia-config/";
          };
        }
      )
    ];

    nix.settings = {
      substituters = ["https://noctalia.cachix.org"];
      trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

    environment.systemPackages = [pkgs.wl-clipboard];

    services.upower.enable = true;
  };
}

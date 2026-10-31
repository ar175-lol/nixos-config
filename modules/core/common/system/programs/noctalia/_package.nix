{
  inputs,
  lib,
  ...
}: let
  mkNoctalia = pkgs: let
    assetsDir = ./assets;

    noctaliaToml =
      lib.replaceStrings ["@ASSETS@"] ["${assetsDir}"]
      (builtins.readFile ./config.toml);
  in
    inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;

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
in {
  flake.overlays.default = final: _: {
    myNoctalia = mkNoctalia final;
  };

  perSystem = {system, ...}: let
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    noctalia = mkNoctalia pkgs;
  in {
    packages.myNoctalia = noctalia;

    apps.myNoctalia = {
      type = "app";
      program = "${noctalia}/bin/noctalia";
    };
  };
}

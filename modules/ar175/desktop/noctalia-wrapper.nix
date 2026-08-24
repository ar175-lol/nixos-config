{
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.myNoctalia = let
      noctaliaV5 = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
      stateDir = "/home/ar175/.local/state/noctalia-config";
    in
      inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;

        package = noctaliaV5;

        enableDumpScript = false;

        constructFiles."config-toml" = {
          key = "configToml";
          relPath = "noctalia-config/config.toml";
          output = "out";
          content = builtins.readFile ./noctalia.toml;
        };

        outOfStoreConfig = stateDir;
        env.NOCTALIA_CONFIG_HOME = "${stateDir}/";
      };
  };
}

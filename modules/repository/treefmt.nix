{inputs, ...}: {
  flake-file.inputs = {
    treefmt.url = "github:numtide/treefmt-nix";
    git-hooks.url = "github:cachix/git-hooks.nix";
  };

  imports = [
    inputs.treefmt.flakeModule
    inputs.git-hooks.flakeModule
  ];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    treefmt = {
      projectRootFile = "flake.nix";

      programs = {
        deadnix.enable = true;
        statix.enable = true;
        alejandra.enable = true;
      };

      settings.formatter = {
        deadnix.priority = 1;
        statix.priority = 2;
        alejandra.priority = 3;
      };
    };

    pre-commit.settings = {
      hooks.treefmt-hook = {
        enable = true;
        name = "Blah blah pluh";
        entry = "${config.treefmt.build.wrapper}/bin/treefmt --fail-on-change --no-cache";
        files = "\\.(nix)$";
      };
    };
    packages.install-hooks = pkgs.writeShellScriptBin "install-hooks" config.pre-commit.installationScript;
  };
}

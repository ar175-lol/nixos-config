inputs:
  inputs.flake-parts.lib.mkFlake {inherit inputs;} {
    systems = ["x86_64-linux"];

    imports = [
      (inputs.import-tree ./modules)
    ];
    debug = true;
  }

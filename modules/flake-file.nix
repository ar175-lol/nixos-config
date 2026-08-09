{
  inputs,
  lib,
  ...
}: {
  flake-file = {
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      flake-parts.url = "github:hercules-ci/flake-parts";
      flake-file.url = "github:denful/flake-file";
      import-tree.url = "github:vic/import-tree";
      home-manager.url = "github:nix-community/home-manager";
    };

    do-not-edit = lib.concatLines (map (line: "# ${line}") (lib.splitString "\n" ''
      Heya! This flake.nix is auto-generated.
      The source of truth for its content is merged from across the modules/ tree.
      Each input is declared in the module where it's actually used.
      https://flake-file.denful.dev/''));
  };

  imports = [inputs.flake-file.flakeModules.default];
}

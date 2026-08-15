{
  inputs,
  lib,
  ...
}: {
  flake-file = {
    inputs = {
      # FIXME: find a file to put these inputs
      flake-parts.url = "github:hercules-ci/flake-parts";
      flake-file.url = "github:denful/flake-file";
      import-tree.url = "github:vic/import-tree";
    };

    do-not-edit = lib.concatLines (map (line: "# ${line}") (lib.splitString "\n" ''
      Heya! This flake.nix is auto-generated.
      The source of truth for its content is merged from across the modules/ tree.
      Each input is declared in the module where it's actually used.
      https://flake-file.denful.dev/''));
  };

  imports = [inputs.flake-file.flakeModules.default];
}

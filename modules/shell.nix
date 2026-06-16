{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    self',
    ...
  }: {
    checks.pre-commit-check = inputs.git-hooks.lib.${system}.run {
      src = ./.;
      hooks = {
        alejandra.enable = true;
        deadnix.enable = true;
        statix = {
          enable = true;
          excludes = ["modules/hosts/victus/hardware\\.nix$"];
        };
      };
    };

    devShells.default = pkgs.mkShell {
      name = "nix-test-shell";

      inherit (self'.checks.pre-commit-check) shellHook;

      nativeBuildInputs = with pkgs; [
        git
        ripgrep
        tree-sitter
        fd
        jq
        alejandra
        deadnix
        statix
      ];
    };
  };
}

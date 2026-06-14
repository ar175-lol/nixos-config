{...}: {
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      name = "nix-test-shell";

      nativeBuildInputs = with pkgs; [
        git
        deadnix
      ];
    };
  };
}

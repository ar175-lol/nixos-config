_: {
  perSystem = {pkgs, ...}: {
    devShells.suckless = pkgs.mkShell {
      name = "suckless";

      inputsFrom = with pkgs; [st];

      nativeBuildInputs = with pkgs; [
        pkg-config
        gnumake
      ];
    };
  };
}

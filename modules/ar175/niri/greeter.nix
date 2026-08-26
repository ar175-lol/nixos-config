{inputs, ...}: {
  flake-file.inputs.noctalia-greeter = {
    url = "github:noctalia-dev/noctalia-greeter";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  users.ar175.nixos.pc = {pkgs, ...}: {
    imports = [inputs.noctalia-greeter.nixosModules.default];

    console.useXkbConfig = false;

    programs.noctalia-greeter = {
      enable = true;

      settings = {
        cursor = {
          theme = "Bibata-Modern-Classic";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
        keyboard = {
          layout = "us,ru";
          options = "grp:alt_shift_toggle";
        };
      };
    };
  };
}

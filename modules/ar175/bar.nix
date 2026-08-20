{lib, ...}: {
  flake-file.inputs.rustbar = {
    url = "github:ar175-lol/oxidizedbar";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  users.ar175.home.gui = {inputs, ...}: {
    imports = [inputs.rustbar.homeModules.default];

    programs.rustbar.enable = true;

    systemd.user.services.rustbar = {
      Service.RuntimeMaxSec = lib.mkForce "12h";
    };
  };
}

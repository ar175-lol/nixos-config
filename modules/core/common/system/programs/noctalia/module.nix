#
{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  cfg = config.modules.system.programs.noctalia;
in {
  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [inputs.self.overlays.default];

    nix.settings = {
      substituters = ["https://noctalia.cachix.org"];
      trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

    environment.systemPackages = [
      pkgs.wl-clipboard
      pkgs.myNoctalia
    ];

    services.upower.enable = true;
  };
}

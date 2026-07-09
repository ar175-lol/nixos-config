_: {
  nixos.base = {
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        trusted-users = ["root" "@wheel"];

        substituters = ["https://cache.nixos.org"];
        trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
      };

      gc.automatic = false;

      extraOptions = ''
        warn-dirty = false
      '';
    };

    nixpkgs.config = {
      allowUnfree = true;
    };
  };
}

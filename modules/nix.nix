_: {
  nixos.modules.base = {
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        trusted-users = ["root" "@wheel"];

        substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://ar175-lol-nix.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "ar175-lol-nix.cachix.org-1:cMlExRCy+tIbEHptjJbhnHb8EBHYIJbEwLqb7x1RWfY="
        ];
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

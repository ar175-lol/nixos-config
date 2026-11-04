{
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["root" "@wheel"];

      # NixOS cache is already in nix config (I hope)
      substituters = [
        "https://nix-community.cachix.org"
        "https://ar175-lol-nix.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ar175-lol-nix.cachix.org-1:cMlExRCy+tIbEHptjJbhnHb8EBHYIJbEwLqb7x1RWfY="
      ];
    };

    gc.automatic = false;

    extraOptions = ''
      warn-dirty = false
    '';
  };

  nixpkgs.config.allowUnfree = true;
}

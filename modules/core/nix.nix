_: {
  nixos.base = _: {
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        trusted-users = ["root" "@wheel"];

        substituters = [
          "https://cache.nixos.org"
          "https://attic.xuyh0120.win/lantian"
          "https://unmojang.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "unmojang.cachix.org-1:OfHnbBNduZ6Smx9oNbLFbYyvOWSoxb2uPcnXPj4EDQY="
        ];
      };
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 5d";
      };

      extraOptions = ''
        warn-dirty = false
      '';
    };

    nixpkgs.config = {
      allowUnfree = true;
    };
  };
}

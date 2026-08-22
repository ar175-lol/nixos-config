{
  nixos.modules.base = {pkgs, ...}: {
    nixpkgs.overlays = [
      (_final: prev: {
        inherit (prev.lixPackageSets.stable) nix-eval-jobs;
      })
    ];

    nix.package = pkgs.lixPackageSets.latest.lix;

    nix.settings.extra-deprecated-features = [
      "broken-string-indentation"
      "rec-set-dynamic-attrs"
      "broken-string-escape"
      "or-as-identifier"
    ];
  };
}

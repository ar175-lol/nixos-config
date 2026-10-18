{pkgs, ...}: {
  nixpkgs.overlays = [
    (_: prev: {
      nix-eval-jobs = prev.lixPackageSets.lix_2_96.nix-eval-jobs;
    })
  ];

  nix = {
    package = pkgs.lixPackageSets.lix_2_96.lix;

    settings.extra-deprecated-features = [
      "broken-string-indentation"
      "rec-set-dynamic-attrs"
      "broken-string-escape"
      "or-as-identifier"
    ];
  };
}

_: {
  nixos.modules.base = {
    nixpkgs.overlays = [
      (
        final: prev: {
          nixdPatched = prev.nixd.overrideAttrs (old: {
            patches =
              (old.patches or [])
              ++ [
                ../../patches/nixd-option-completion-scope.patch
              ];
          });
        }
      )
    ];
  };
}

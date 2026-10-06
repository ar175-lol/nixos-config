_: {
  # nixd rebuilds the option path for the cursor by walking the enclosing
  # attribute sets. That misfires on this config's dendritic layout, where a
  # module assigns config to a nested path with no function header:
  #
  #   users.ar175.nixos.pc = {
  #     time.timeZone = "Asia/Almaty";
  #   };
  #
  # "users.ar175.nixos.pc" is module plumbing, not option path, so nixd asked its
  # workers for ["users","ar175","nixos","pc","time"] and got
  # "attrname users not found in attrset" -- zero completions. Adding a "{...}:"
  # header masks it, which is why the bug seems to come and go.
  #
  # Only one patch is needed. nixd reads its configuration exclusively from the
  # LSP "workspace/configuration" request, which Zed serves from
  # "lsp.nixd.settings" (see the comment in editor/zed.nix). No patch is
  # required to make that work.
  #
  # The remaining bug has no configuration workaround: nixd rebuilds the option
  # path for the cursor by walking the enclosing attribute sets, which misfires
  # on this dendritic layout.
  #
  # See ../../patches/README.md for details and measurements.
  # Upstream issues, none of which cover these cases:
  #   https://github.com/nix-community/nixd/issues/835 (also #713, #643, #738, #852)
  nixos.modules.base = {
    nixpkgs.overlays = [
      (
        _final: prev: {
          nixdPatched = prev.nixd.overrideAttrs (old: {
            patches =
              (old.patches or [])
              ++ [../../patches/nixd-option-completion-scope.patch];
            # Deliberately NOT bumping "version".
            #
            # NOTE: this must stay a *separate* attribute instead of overriding
            # "nixd" in place. nixpkgs' devenv bakes a nixd store path into its
            # postInstall (devenv ships nixd for built-in LSP support), so any
            # change to nixd's output path changes devenv's drv hash and forces
            # a full rebuild of devenv's Rust/cargo closure (aws-lc-rs, hyper,
            # rustls, tower), none of which are substitutable from cache.
            # Keeping "nixd" untouched leaves devenv's drv identical to the one
            # already in the store, so devenv never rebuilds.
          });
        }
      )
    ];
  };
}

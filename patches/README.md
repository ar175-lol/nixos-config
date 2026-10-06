# Patches

You can take this patches to your config, edit them, or even contribute this
to `nixd`! But remember, these patches was **written by AI**.

## `nixd-option-completion-scope.patch`

nixd rebuilds the option path for the cursor by walking the enclosing attribute
sets. That misfires on a dendritic layout, where a module assigns config to a
nested path with no function header:

```nix
users.ar175.nixos.pc = {
  time.timeZone = "Asia/Almaty";
};
```

`users.ar175.nixos.pc` is module plumbing, not option path, so nixd asks its
workers for `["users","ar175","nixos","pc","time"]` and gets
`attrname users not found in attrset` — no completions at all.

Adding a `{...}:` header after the `=` masks the problem, which is why the bug
seems to come and go.

The patch retries successively shorter suffixes of the computed path and keeps
the first scope a provider can actually resolve. It also tries a path with a
leading `options` stripped, since flake-parts keeps its own options under
`options.` while NixOS/Home-Manager do not.

Measured over 71 completion positions in this config: 17 fixed, 0 regressions.

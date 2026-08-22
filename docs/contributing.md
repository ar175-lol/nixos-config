# Contributing

## Formatting

treefmt pipeline runs on commit (pre-commit hook) and in CI:
`deadnix` → `statix` → `alejandra`. Run manually with `nix fmt`.

Hooks are declared with git-hooks.nix inside the flake; `.pre-commit-config.yaml` is generated
(`DO NOT MODIFY`). Install with:

```bash
nix run .#install-hooks
```

## CI

`.github/workflows/check.yml` (pushes/PRs to `main`): `nix flake check` + builds both hosts
(`victus`, `iso`) + pushes to Cachix `ar175-lol-nix`. If CI builds it, it builds everywhere.

## Recipes

### New feature

Create any file under `modules/` targeting a scope — no registration needed:

```nix
# modules/foo.nix
_: {
  users.ar175.home.base = {pkgs, ...}: {
    programs.bat.enable = true;
  };
}
```

### New input

Declare it in the module that uses it, then regenerate:

```nix
{inputs, ...}: {
  flake-file.inputs.my-tool.url = "github:someone/my-tool";
}
```

```bash
nix run .#write-flake && sync
```

### New machine

1. Hardware report: `modules/computers/hardware-<name>.nix`.
2. Assembly: `modules/computers/<name>.nix` listing scopes in `nixos.configurations.<name>.modules`.
3. Check: `nix build .#nixosConfigurations.<name>.config.system.build.toplevel`.

Data files (JSON, images, `_*.nix`) can sit next to feature modules — they are not auto-imported.

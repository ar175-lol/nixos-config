# Contributing

## Recipes

### New feature

Create any file under `modules/` targeting a scope — no registration needed:

```nix
# modules/foo.nix
_: {
  users.ar175.home.base = {pkgs, ...}: {
    programs.bar.enable = true;
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
sync
```

### New machine

1. Hardware report: `modules/computers/hardware-<name>.nix`.
2. Assembly: `modules/computers/<name>.nix` listing scopes in `nixos.configurations.<name>.modules`.

Data files (JSON, images, `_*.nix`) can sit next to feature modules — they are not auto-imported.

# Editing conventions and recipes

## Module shape

A normal program module looks like this:

```nix
{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.programs.steam;
in {
  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
  };
}
```

Rules that follow from the module system:

- **Imports must be a concrete list.** The module system runs `length`/`imap1`
  over `imports`, so `imports = lib.mkIf ...` is a type error. Gate `config`, as
  above, never `imports`.
- **A plain attrset module has no arguments.** To use `pkgs`, `lib`, `config`, or
  `inputs`, write the module as a function: `{pkgs, ...}: { ... }`.
- **Feature options live in `modules/options/`.** Do not declare feature options in
  the implementation file. This keeps the option surface in one place and makes
  `rg "programs.foo"` find both the declaration and every consumer.
- **Every common module is always imported.** The `lib.mkIf cfg.enable` is what
  makes it a toggle.
- **Profiles and roles are defaults.** They use `lib.mkDefault`; do not use
  `lib.mkForce` to win an argument with a host assignment.

## Home Manager

Place user-specific Home Manager configuration in `homes/<user>/`. The account's
`homeModules` defaults to `homes/<user>/home.nix` when that file exists, so most
hosts do not mention it at all. A home module can use
`{config, osConfig, pkgs, inputs, self, ...}` normally, but should configure the
selected user directly rather than gate itself behind a NixOS program option.
`userModule` sets each account's `home.stateVersion` from the host's
`system.stateVersion`; `core/common/system/home-manager.nix` provides global packages and
`extraSpecialArgs = {inherit inputs self;}`.

Do not add a shared `modules/home` tree or inject user config through
`home-manager.sharedModules`.

## Overlays and flake packages

Two different mechanisms exist:

- Wrapped applications from `modules/core/common/system/nix/overlays.nix` are defined in
  `nixpkgs.overlays`, so they are reachable as `pkgs.myTerminal`, `pkgs.myYazi`,
  and `pkgs.myTmux` from any module.
- `modules/core/common/system/programs/noctalia/_package.nix` defines
  `flake.overlays.default` for `myNoctalia`. The Noctalia module applies
  `inputs.self.overlays.default` when enabled, which is why `pkgs.myNoctalia`
  resolves in `niri.nix`.
- `neovim/_package.nix` and `noctalia/_package.nix` also expose
  `perSystem.packages.*` and `perSystem.apps.*` for `nix build`/`nix run`.

A `_package.nix` is not imported automatically. Add it to the `imports` list in
`outputs.nix` explicitly if you create another one.

## Recipes

### Add a host

1. Create `hosts/<name>/host.nix` with `hosts.<name> = { ... };`.
2. Add `./hosts/<name>/host.nix` (or the directory file you use) to
   `hosts/default.nix`. Registration is manual.
3. Set `enable = true`, `hostName`, `stateVersion`, `users`, and `roles`.
4. Add per-host `features` and, only if needed, `extraModules` (filesystem layout,
   kernel module, installer module).
5. Verify:
   `nix build .#nixosConfigurations.<name>.config.system.build.toplevel --dry-run`

### Add a program

1. Add `foo.enable = lib.mkEnableOption "foo";` to
   `modules/options/programs.nix`.
2. Create `modules/core/common/system/programs/foo.nix` with the `cfg`/`mkIf` pattern above.
   It is auto-imported by the `core/common` tree; do not add an import anywhere.
3. Enable it in a profile (with `mkDefault`) or in a host's `features`.
4. If it needs assets or shared data, create
   `modules/core/common/system/programs/foo/` with `module.nix` and `_data.nix`/assets.
   Non-Nix assets beside the module are fine.

### Add a profile

1. Declare `modules.profiles.<name>.enable` in `modules/options/profiles.nix`.
2. Create `modules/core/profiles/<name>/module.nix` that gates on the option and
   enables programs with `lib.mkDefault`.
3. Enable the profile in a host's `features.modules.profiles.<name>.enable`.

### Add a role

1. Create `modules/core/roles/<name>/` with at least one `.nix` file.
   `module.nix` is the conventional main file.
2. Set role defaults with `lib.mkDefault`; role files are imported unconditionally
   for hosts that list the role.
3. Add `"<name>"` to a host's `roles` list. There is no other registration.

### Add a flake input

1. Add the input to the `inputs` set in `flake.nix`.
2. Update the lock with `nix flake update <name>` (or `nix flake lock`).
3. Consume it as `inputs.<name>` in `outputs.nix` or any module.

### Add a flake-level package or app

1. Create `modules/core/common/system/programs/<thing>/_package.nix` (or another `_`-prefixed
   file) so import-tree does not import it into every NixOS system.
2. Add it to the `imports` list in `outputs.nix`.
3. Use `perSystem` for `packages.<name>` / `apps.<name>`, and/or
   `flake.overlays.default` for a `pkgs.<name>` overlay.
4. If it is an overlay, apply it in the consuming module
   (`nixpkgs.overlays = [...]`).

### Change a host's filesystem or boot setup

Put it in a per-host file (for example `hosts/apollo/fs.nix`) and add it to that
host's `extraModules`. Do not add another host's disk UUIDs or initrd modules to a
common module.

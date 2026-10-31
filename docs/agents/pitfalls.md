# Pitfalls and assumptions

## Hard rules and gotchas

- **`flake.nix` is hand-maintained.** Add inputs there and update the lock with
  `nix flake update <name>`. `outputs.nix` remains the real entry point.
- **Never gate `imports`.** Use `config = lib.mkIf ...`. `imports` must be a
  concrete list.
- **Respect the underscore convention.** import-tree skips `_`-prefixed files and
  directories. If you create `_package.nix` or `_data.nix`, import it explicitly
  where needed; if you want auto-import, do not prefix it.
- **Do not change `stateVersion`** unless you are intentionally performing a
  release upgrade and understand the consequences. Both hosts are `26.05`.
- **Profiles are defaults.** They use `mkDefault`; a host feature setting the same
  option at normal priority overrides them. Do not use `mkForce` to win an argument
  with a default.
- **Roles are unconditional.** A role directory is imported whole for a host that
  lists it. Do not expect a role to be a toggle; use `features` or a program option
  for behavior that must be conditional.
- **NixOS feature options are declared only in `modules/options/`.** The
  flake-parts `hosts` option is the exception, declared in
  `modules/tree/module.nix`. Implementations read `config.modules.*`.
- **Plain attrset modules get no arguments.** Use a function for `lib`, `pkgs`,
  `config`, or `inputs`.
- **Host registration is manual.** A new `hosts/<name>/host.nix` does nothing until
  it is imported by `hosts/default.nix`.
- **`features` is a module, not a nested option.** Config under
  `features.modules.*` is the same as config under `modules.*` in any other NixOS
  module. It can also set stock NixOS options directly.
- **`hosts` is a flake-parts option.** It is declared in `modules/tree/module.nix`,
  not in `modules/options/`.
- **`import-tree` imports `.nix` files only.** TOML/PNG assets are ignored; this is
  why they can sit next to `module.nix`.
- **Home Manager is per-user.** Put it under `homes/<name>/`; `users.<name>.homeModules`
  defaults to `homes/<name>/home.nix` when present. Do not add a shared
  `modules/home` tree.
- **Imports go downward and one level.** `./foo.nix` is fine; `../../foo/bar.nix`
  is not. Cross-tree wiring belongs in `outputs.nix` or `hosts/default.nix`.
  Use `self.outPath + "/path/from/root"` for the few root-relative references;
  `self` is available in flake-parts and is forwarded to NixOS and Home Manager.
- **Do not commit plaintext secrets.** `hosts/apollo/host.nix` contains hashed
  passwords; do not add tokens or passwords in plaintext. `homes/ar175/git.nix`
  contains the user's identity and signing key path.
- **CI auto-commits formatting.** Expect `format.yml` to rewrite Nix files on
  `main`; run the formatters yourself instead of relying on it.
- **`debug = true` in `outputs.nix` is intentional.** It exposes flake-parts
  `debug.options`, which the Neovim nixd setup uses for completions. Do not remove
  it casually.
- **`README.md` is design rationale and may lag.** The code and this docs tree are
  authoritative.

## Hardcoded assumptions

These are the places that assume the current user (`ar175`) or checkout path. If
you add another user or move the repository, update them deliberately:

- `modules/hardware/virtualisation.nix` — adds `ar175` to `libvirtd`.
- `modules/core/common/system/programs/printing.nix` — adds `ar175` to `scanner` and `lp`.
- `modules/core/common/system/programs/noctalia/config.toml` — avatar path is
  `/home/ar175/.face.jpg`.
- `modules/core/common/system/programs/neovim/_settings.nix` — nixd uses
  `/home/ar175/nixos-config` and the `apollo` host for option evaluation.
- `homes/ar175/programs/terminal/tools/nh/default.nix` — flake path is
  `${config.home.homeDirectory}/nixos-config`.
- `homes/ar175/programs/terminal/shell/noctalia.nix` — `noctalia-sync` assumes
  `$HOME/nixos-config` and runs `nh os switch`.
- `homes/ar175/git.nix` — user name, email, and SSH signing key.
- `hosts/apollo/host.nix` — account names, groups, and hashed passwords.

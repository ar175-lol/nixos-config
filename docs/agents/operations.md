# Operations

Run these from the repository root unless noted.

| Goal | Command |
|---|---|
| Evaluate/check the flake | `nix flake check --show-trace --fallback --no-build` |
| Quick evaluation of apollo | `nix build .#nixosConfigurations.apollo.config.system.build.toplevel --dry-run` |
| Build apollo | `nix build .#nixosConfigurations.apollo.config.system.build.toplevel` |
| Build the ISO | `nix build .#nixosConfigurations.iso.config.system.build.isoImage` |
| Prove a change is inert | `nix eval .#nixosConfigurations.apollo.config.system.build.toplevel.drvPath` |
| Apply on apollo | `nh os switch` (run from `~/nixos-config`) |
| Format | `nix fmt` (alejandra) |
| Full CI formatting parity | `nix run nixpkgs#deadnix -- --edit .` then `nix run nixpkgs#statix -- fix .` then `nix run nixpkgs#alejandra .` |
| Regenerate `flake.nix` | `nix run .#write-flake` |
| Build the standalone Neovim | `nix build .#myNeovim` |
| Build the standalone Noctalia | `nix build .#myNoctalia` |

Notes:

- There is no test suite. Evaluation, builds, and `drvPath` comparison are the
  verification tools. An identical `drvPath` means the system definition did not
  change.
- `nh` is configured with `flake = "$HOME/nixos-config"`. `apollo` disables sudo
  and uses doas, so make sure the command can elevate when it needs to.
- `nix fmt` only runs alejandra. CI also runs deadnix and statix, so run all three
  before handing off code.
- `nix flake check --no-build` still evaluates both hosts; it is the fastest
  broad sanity check.

## CI

- `.github/workflows/check.yml` — on PRs to `main` touching `modules/**`,
  `flake.nix`, `flake.lock`, or `.github/**`, on pushes to `main`, and manually.
  Runs `nix flake check --show-trace --fallback --no-build` and a dry build of
  apollo.
- `.github/workflows/format.yml` — on pushes to `main` touching `**/*.nix`, and
  manually. Runs deadnix, statix, and alejandra, then auto-commits changes as
  `chore(nix): formatting` with the GitHub Actions bot. Format locally to avoid
  surprise commits.
- `.github/workflows/build.yml` — manual. Builds the `apollo` and `iso` toplevel
  derivations and pushes to the `ar175-lol-nix` Cachix cache.
- `.github/workflows/build-iso.yml` — manual. Builds `isoImage`, splits it into
  1900 MiB parts, uploads artifacts, and optionally creates a release when a tag
  is supplied.

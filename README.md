# nixos-config

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

NixOS for all my stuff!

## Screenshots
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/eb609ea9-b4ef-4950-8b9c-18a99e58b95d" />


## Layout

```
flake.nix              hand-maintained flake inputs; delegates to outputs.nix
outputs.nix            flake-parts entry point
hosts/                 one directory per machine, each with host.nix
homes/                 per-user Home Manager configurations
  ar175/
  mom/
secrets/               agenix-encrypted secrets and recipient rules
modules/
  tree/
    default.nix          declares the `hosts` option, builds every machine
  options/              the option surface: device, profiles, programs, services, system
  core/
    common/             always on for every host
      system/           boot, doas, nix, opt-in programs and services
    profiles/           graphical, workstation, laptop, gaming -- software bundles
  hardware/             audio, bluetooth, gpu, power, adb, ...
```

Each account's Home Manager entry point defaults to `homes/<username>/home.nix`.
User programs and settings are kept with that account rather than shared through a
NixOS module.

Assets used by a system program live beside it, e.g.
`modules/core/common/system/programs/noctalia/assets/`.

Files under `modules/` whose names start with `_` hold shared configuration
or data and are skipped by import-tree. Flake-level package modules such as
`core/common/system/programs/neovim/_package.nix` are imported explicitly by
`outputs.nix`.

## Machines

Machines are entries in the `hosts` option, one directory each under `hosts/`,
listed in `hosts/default.nix`. Each contributes a `host.nix`; the directory can
hold more (a kernel, a filesystem layout, per-concern modules) without changing
anything else. Adding a machine is a new directory plus one line. For example, here is my `apollo` host:
```nix
{
  inputs,
  ...
}: {
  hosts.apollo = {
    enable = true;
    hostName = "apollo";
    stateVersion = "26.05";

    users.ar175 = {
      shell = "zsh";
      extraGroups = ["wheel" "video"];
    };

    features = {
      modules = {
        device.hasSound = true;

        system.programs.steam.enable = false;

        profiles = {
          graphical.enable = true;
          workstation.enable = true;
          laptop.enable = true;
          gaming.enable = true;
        };
      };
    };
  };
}
```

There are three axes, and they answer different questions:

- **`modules.device.*`** is capability: what hardware this machine has.
- **`modules.profiles.*`** is identity: what the machine *is*. Profiles name the
  archetype and are imported for every host, gated by their enable option. They
  turn the programs and services they need on with `mkDefault`.
- **`modules.system.programs.*` / `modules.system.services.*`** is system
  software. A host can override any single piece at normal priority while
  keeping a profile enabled. Some pieces (Bottles, qBittorrent, Prism Launcher)
  are Home Manager packages that read the same options through `osConfig`.
  Per-user programs are configured separately under `homes/<username>/`.

`users` is keyed by account name; each entry creates a system account and a
Home Manager generation. Its `homeModules` defaults to `homes/<username>/home.nix`
when present, so different users can have different programs and settings. Keep
those modules in `homes/<username>/`.

`features` is inserted into the system as a module, so `lib` and `pkgs` are in
scope inside function modules used there.

| Host | What it is |
|---|---|
| `apollo` | the workstation: Plasma and Niri sessions, SDDM, NVIDIA; gaming profile on with Steam off |
| `iso` | Calamares installer with the `graphical` profile |

The gaming profile enables the matching `modules.system.programs.*` options:
`steam`, `bottles`, `qbittorrent`, and `prismlauncher`. Steam is a system
program; Bottles, qBittorrent, and Prism Launcher are Home Manager packages that
read the same options through `osConfig`. Enabling the profile defaults every
piece on, and a host can disable any single one; `apollo` turns Steam off this
way.

## How it fits together

The option surface lives in `modules/options/` and is imported into **every**
host. The modules under `core/common`, `core/profiles`, and `hardware` are too;
profiles are gated by their enable options, not by per-host imports. A module
that only affects some machines owns no option of its own: it reads one of the
central options and wraps its config in `lib.mkIf`:

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

Adding a feature never requires touching `hosts/default.nix` to import it: the
module is already in every system, waiting on its option. A new profile is just
an option plus a module in `core/profiles/`; no host import list changes.

### Three things that are not obvious

- **`imports` must be a concrete list.** `lib/modules.nix` runs `imap1` (and so
  `length`) over it, so `imports = lib.mkIf ...` is a type error. Only `config`
  can be gated.
- **Option and implementation are split on purpose.** Declarations live in
  `modules/options/`; implementations read them from anywhere. The option
  surface is one readable list, and `rg "profiles.gaming"` finds every user of
  an option and its single declaration.
- **A plain attrset module has no arguments.** To use `pkgs` or `lib` inside a
  value that becomes a module, write it as `{pkgs, ...}: {...}`.

### Cross-cutting modules

- Wrapped applications (`pkgs.myTerminal`, `myYazi`, `myTmux`, `myNoctalia`)
  come from `nixpkgs.overlays`, so they are reachable as `pkgs.*` from any
  module. They used to be built in a flake-parts `perSystem` block, which forced
  every consumer through `self.packages.${system}.myX`.
- Home Manager configuration lives under `homes/<username>/` and is selected by
  convention through `homeModules`; it does not use a shared NixOS program switch.
- Imports go downward and one level. Root-level wiring (`outputs.nix`,
  `hosts/default.nix`) is the only place that crosses trees; everything else is
  auto-imported or found by convention. Use `self.outPath + "/..."` when a
  root-relative path is genuinely needed.

## Partitioning

The on-disk layout is declared in `hosts/apollo/modules/fs.nix` as plain
`fileSystems`. disko was never wired up -- its layout file was imported by
nothing -- and has been removed.

## Secrets

Account password hashes are encrypted with [agenix][agenix-url] and stored under
`secrets/`; `hosts/apollo/modules/secrets.nix` wires them to
`users.users.<name>.hashedPasswordFile`. The `.age` files are safe to commit.
Never commit decrypted secrets, private age/SSH keys, or plaintext hashes.
See [docs/secrets.md](docs/secrets.md) for editing, rekeying, and host-key
setup.

## Verifying a change

Comparing derivation paths is the only trustworthy check that a config change
did not alter anything:

```bash
nix eval .#nixosConfigurations.apollo.config.system.build.toplevel.drvPath
```

An identical path means the system definition is unchanged.

## Flake inputs

`flake.nix` is hand-maintained. Add or edit inputs directly, then update the lock:

```bash
nix flake update <name>
```

## Credits

Thank you:

- [mightyiam][mightyiam-url] for the dendritic pattern this config used to be
  built around, and for writing down its anti-patterns — which is what the
  current layout is a response to.
- [NotAShelf][notashelf-url] for [nyx][nyx-url], whose structure (a `hosts/`
  directory per machine, a typed machine option, home-manager wired from the
  host's own user list) shaped this rebuild.

[mit-url]: https://opensource.org/license/mit/
[dendritic-url]: https://github.com/mightyiam/dendritic
[anti-patterns-url]: https://github.com/mightyiam/dendritic#anti-patterns
[mightyiam-url]: https://github.com/mightyiam
[notashelf-url]: https://github.com/NotAShelf
[nyx-url]: https://github.com/NotAShelf/nyx
[niri-url]: https://github.com/YaLTeR/niri
[noctalia-url]: https://github.com/noctalia-dev/noctalia
[wrapper-url]: https://github.com/BirdeeHub/nix-wrapper-modules
[foot-url]: https://codeberg.org/dnkl/foot
[zsh-url]: https://www.zsh.org/
[starship-url]: https://starship.rs/
[zed-url]: https://zed.dev/
[agenix-url]: https://github.com/ryantm/agenix
[home-manager-url]: https://github.com/nix-community/home-manager
[zen-url]: https://zen-browser.app/
[zen-flake-url]: https://github.com/0xc000022070/zen-browser-flake

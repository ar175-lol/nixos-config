# NixOS configuration

The [dendritic pattern](https://github.com/mightyiam/dendritic) applied to my NixOS setup.

> [!WARNING]
> This is a hardware-specific configuration! Use at your own risk.

## Structure

Every Nix file under `modules/` is a top-level module implementing **one feature**
(`import-tree` imports them automatically). Features span whatever configurations
they apply to (NixOS, home-manager, or both). File paths merely name the feature,
so files can be renamed and moved freely.

```
modules/
├── ar175/            # user ar175 (victus): shells, apps, editors
│   ├── _policies.nix # data file, excluded from auto-import (leading `_`)
│   ├── niri/         # window manager (system + home)
│   └── …               
├── kirk/             # user kirk (dkirk)
├── computers/        # machines: victus, dkirk, iso (hardware + assembly)
├── hardware/         # machine hardware features (nvidia, tlp, zram, amd, …)
├── networking/       # iwd, dnscrypt, firewall
├── editor/           # nvim via nixvim, one file per feature
├── boot/             # base boot + loaders (grub, limine)
├── options/          # nixos.modules.{base,pc,laptop} option declarations
├── repository/       # repo concerns (flake-file)
└── <root>            # base features: audio, nix, starship, tmux, doas, …
```

### Wiring

- `nixos.modules.base` — applies to every machine (audio, nix, boot, debloat, doas,
  firewall, dnscrypt, iwd, disko module, …).
- `nixos.modules.pc` / `nixos.modules.laptop` — machine profiles layered on `base`.
- `users.<name>.nixos.{base,pc}` — system config scoped to a user's machine.
- `users.<name>.home.{base,gui}` — home-manager config (base = CLI, gui = graphical).

Machines (`modules/computers/*.nix`) assemble these into
`nixos.configurations.<machine>.modules`.

## Machines & users

| Machine | Hostname | User | Profile |
|---|---|---|---|
| victus   | `victus` | ar175 | laptop: niri + limine + iwd + xanmod |
| dkirk    | `dkirk`  | kirk  | pc: plasma + grub + networkmanager-free |
| iso      | `nixos`  | nixos | rescue/installer ISO (greetd + niri) |

Disk layout for victus is declared with **disko** in
`modules/computers/hardware-victus.nix` (btrfs subvols `/root`, `/home`, `/nix` +
vfat `/boot`).

## Adding a feature

Create a file named after the feature, e.g. `modules/ar175/foo.nix`:

```nix
_: {
  users.ar175.home.base = {pkgs, ...}: {
    programs.foo.enable = true;
  };
}
```

To add a flake input, declare it inside the feature that uses it:

```nix
_: {
  flake-file.inputs.foo.url = "github:owner/foo";
  users.ar175.home.base = {inputs, ...}: {
    imports = [inputs.foo.homeModules.default];
  };
}
```

Then regenerate the lockfile & `flake.nix`:

```bash
nix flake lock
nix run .#write-flake
```

## Build & switch

```bash
nix flake check
nix build .#nixosConfigurations.victus.config.system.build.toplevel
nh os switch          # or: sync/update/clean aliases (ar175 zsh)
```

> [!CAUTION]
> Replace my `hardware-victus.nix` / `hardware-dkirk.nix` with your own
> hardware configuration, or your boot is **cooked**.
> Never run `disko` on a machine you don't intend to repartition!

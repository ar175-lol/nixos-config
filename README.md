# NixOS configuration

Modular NixOS configuration which follows [dendritic pattern](https://github.com/mightyiam/dendritic).

> [!CAUTION]
> Replace `hardware-victus.nix` or `hardware-dkirk.nix` with your own
> hardware configuration, or your boot is **cooked**.

## Programs
My main host uses:
- `niri` compositor with `lightdm` (temp).
- [rustbar](https://github.com/ar175-lol/oxidizedbar) as main bar, [mako-rs](https://github.com/ar175-lol/mako-rs) as main notificator app.
- `foot` + `zsh` + `starship` as terminal stuff.
- `neovim` configured via `nixvim` as editor.
- `yazi` and `nautilus` as file explorers
- Zen Browser configured via [zen-browser-flake](https://github.com/0xc000022070/zen-browser-flake)
- And a lot of other things (maybe...)!
---
`dkirk` host uses:
- Debloated KDE Plasma as DE.
- Zen Browser
- `dolphin` as main file manager
- `kate`/`neovim` as editor.

### Installation 
```bash
git clone https://github.com/ar175-lol/nixos-config.git
nix  --experimental-features "nix-command flakes" run \
    github:nix-community/disko -- --mode disko --argstr device /dev/disk/by-id/nvme-eui.00000000000000008ce38e10010b221d nixos-config/disko/victus.nix
nixos-install --root /mnt --flake .#victus # or dkirk
```

### Structure

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
├── editor/           # nvim via nixvim
├── boot/             # base boot + loaders (grub, limine)
├── options/          # nixos.modules.base option declaration
├── repository/       # repo concerns (flake-file)
└── <root>            # base features: audio, nix, ...
```

### Wiring

- `nixos.modules.base` — applies to every machine (audio, nix, boot, debloat,
  firewall, dnscrypt, iwd, disko module, …).
- `users.<name>.nixos.{base,pc}` — system config scoped to a user's machine.
- `users.<name>.home.{base,gui}` — home-manager config (base = CLI, gui = graphical).

Machines (`modules/computers/*.nix`) assemble these into
`nixos.configurations.<machine>.modules`.

### Machines & users

| Machine | Hostname | User | Profile |
|---|---|---|---|
| victus   | `victus` | ar175 | laptop: niri + limine + iwd + xanmod |
| dkirk    | `dkirk`  | kirk  | pc: plasma + grub + networkmanager-free |
| iso      | `nixos`  | nixos | rescue/installer ISO (greetd + niri) |


> [!NOTE]
> Main host is `victus`. `dkirk` is my friends configuration (written with me btw).

### Build & switch

```bash
nh os switch # or `sync` alias
```

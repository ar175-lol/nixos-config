# Options and inventory

## Option surface

All NixOS feature options live in `modules/options/`. (The flake-parts `hosts`
option is separate, in `modules/tree/module.nix`.) Implementations never declare
their own options; they read `config.modules.*`.

- `modules.device`: `hasSound`, `hasBluetooth`, `cpu.type` (`"intel"`/`"amd"`/null),
  `gpu.intel.enable`, `gpu.nvidia.enable`, `gpu.nvidia.prime.*`.
- `modules.system`: `loader.enable`, `doas.enable`, `fonts.enable`, `zram.enable`,
  `powerSave.enable`, `automount.enable`.
- `modules.profiles`: `workstation.enable`.
- `modules.system.programs`: `plasma`, `niri`, `greeter`, `noctalia`, `tmux`,
  `neovim`, `opencode`, `localsend`, `kdenlive`, `libreoffice`, `flatpak`, `steam`,
  `virtualisation`, `adb`, and `printing` — all with `.enable`.

There is no `modules.profiles.gaming` or `modules.system.programs.gaming` in the
current tree. Steam and Flatpak are direct
`modules.system.programs.{steam,flatpak}` toggles in a host's `features`, not a
profile.

## Role defaults

- `graphical`: enables `fish` and `zsh`, and defaults `niri`, `greeter`, `noctalia`,
  and `tmux` on.
- `workstation`: defaults `virtualisation`, `adb`, `printing`, and `doas` on.
- `laptop`: defaults `powerSave` and `zram` on.

## Profile contents

- `workstation`: neovim, opencode, localsend, libreoffice, and kdenlive.
- No other profiles currently exist.

## Module inventory

Always imported from `core/common`:

- `boot.nix` — xanmod kernel, Plymouth, quiet boot, tmp cleanup.
- `debloat.nix` — disables ModemManager, nscd, timesyncd, speechd, core dumps,
  selected sockets/timers, and most docs.
- `dns.nix` — dnscrypt-proxy on `127.0.0.1`; resolved/resolvconf off.
- `firewall.nix` — nftables and the firewall.
- `fonts.nix` — Monocraft; default font packages when
  `modules.system.fonts.enable` is true.
- `home-manager.nix` — home-manager integration and common arguments.
- `lix.nix` — Lix 2.96 as the Nix implementation.
- `locale.nix` — `Asia/Almaty`, `en_US.UTF-8`, British measurement/numeric/paper/time.
- `networking.nix` — iwd, no NetworkManager, dhcpcd off by default.
- `nix.nix` — flakes, store optimisation, Cachix substituters, no automatic GC,
  `allowUnfree`.
- `packages.nix` — `myTerminal`, `myYazi`, `myTmux` wrapper overlays.

Roles:

- `graphical/module.nix` — fish/zsh plus niri, greeter, noctalia, and tmux defaults.
- `graphical/portal.nix` — xdg portals and the yazi-based terminal file chooser.
- `workstation/module.nix` — doas, virtualisation, adb, printing defaults.
- `laptop/module.nix` — powerSave and zram defaults.

Profiles:

- `workstation/module.nix` — everyday desktop programs, enabled with `mkDefault`.

Hardware (all gated by the matching `modules.*` option):

- `adb.nix`, `audio.nix`, `automount.nix`, `bluetooth.nix`, `power-save.nix`,
  `virtualisation.nix`, `zram.nix`, `cpu/{amd,intel}.nix`, `gpu/{intel,nvidia}.nix`.

System:

- `doas.nix` — disables sudo, enables passwordless doas for wheel.
- `loader.nix` — Limine when `modules.system.loader.enable` is true.
- `programs/<name>.nix` — one file per selectable program: `flatpak`, `greeter`,
  `kdenlive`, `libreoffice`, `localsend`, `niri`, `opencode`, `plasma`, `printing`,
  `steam`, `tmux`, plus `noctalia/` and `neovim/`.
- `programs/neovim/` and `programs/noctalia/` are directories because they carry
  settings, assets, or flake-level package outputs.

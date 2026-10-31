# Options and inventory

## Option surface

All NixOS feature options live in `modules/options/`. (The flake-parts `hosts`
option is separate, in `modules/tree/module.nix`.) Implementations never declare
their own options; they read `config.modules.*`.

- `modules.device`: `hasSound`, `hasBluetooth`, `hasWifi`, `hasEthernet`,
  `cpu.type` (`"intel"`/`"amd"`/null), `gpu.intel.enable`, `gpu.nvidia.enable`,
  `gpu.nvidia.prime.*`.
- `modules.system`: `loader.enable`, `doas.enable`, `fonts.enable`, `zram.enable`,
  `powerSave.enable`.
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

Always imported from `core/common/system`:

- `home-manager.nix` — home-manager integration and common arguments.
- `nix/module.nix` — flakes, store optimisation, Cachix substituters, no
  automatic GC, `allowUnfree`.
- `nix/lix.nix` — Lix 2.96 as the Nix implementation.
- `nix/overlays.nix` — `myTerminal`, `myYazi`, `myTmux` wrapper overlays.
- `os/boot.nix` — xanmod kernel, Plymouth, quiet boot, tmp cleanup.
- `os/debloat.nix` — disables ModemManager, nscd, timesyncd, speechd, core dumps,
  selected sockets/timers, and most docs.
- `os/doas.nix` — disables sudo, enables passwordless doas for wheel.
- `os/fonts.nix` — Monocraft; default font packages when
  `modules.system.fonts.enable` is true.
- `os/loader.nix` — Limine when `modules.system.loader.enable` is true.
- `os/locale.nix` — `Asia/Almaty`, `en_US.UTF-8`, British
  measurement/numeric/paper/time.
- `os/networking/module.nix` — iwd when `hasWifi`; dhcpcd when `hasEthernet`
  (denying `wlan*` when both are on); no NetworkManager.
- `os/networking/dns.nix` — dnscrypt-proxy on `127.0.0.1`; resolved/resolvconf
  off.
- `os/networking/firewall.nix` — nftables and the firewall.

Roles:

- `graphical/module.nix` — fish/zsh plus niri, greeter, noctalia, and tmux defaults.
- `graphical/portal.nix` — xdg portals and the yazi-based terminal file chooser.
- `workstation/module.nix` — doas, virtualisation, adb, printing defaults.
- `laptop/module.nix` — powerSave and zram defaults.

Profiles:

- `workstation/module.nix` — everyday desktop programs, enabled with `mkDefault`.

Hardware (all gated by the matching `modules.*` option):

- `adb.nix`, `audio.nix`, `bluetooth.nix`, `power-save.nix`,
  `virtualisation.nix`, `zram.nix`, `cpu/{amd,intel}.nix`, `gpu/{intel,nvidia}.nix`.

System programs (`core/common/system/programs/`):

- `<name>.nix` — one file per selectable program: `flatpak`, `greeter`,
  `kdenlive`, `libreoffice`, `localsend`, `niri`, `opencode`, `plasma`, `printing`,
  `steam`, `tmux`, plus `noctalia/` and `neovim/`.
- `neovim/` and `noctalia/` are directories because they carry settings, assets,
  or flake-level package outputs.

# Domain behavior

## Noctalia configuration

`modules/core/common/system/programs/noctalia/config.toml` is the Noctalia shell config used to
build `pkgs.myNoctalia`. `_package.nix` replaces the `@ASSETS@` placeholder with
the path to `modules/core/common/system/programs/noctalia/assets/`, writes the result to
`$out/noctalia-config/noctalia/config.toml`, and sets `NOCTALIA_CONFIG_HOME`.

The `noctalia-sync` shell command (installed by
`homes/ar175/programs/terminal/shell/noctalia.nix`) works in the opposite direction:
it reads `~/.local/state/noctalia/settings.toml`, rewrites asset paths to
`@ASSETS@`, writes the repo's `config.toml`, stages it, and runs `nh os switch`.
Editing `config.toml` by hand is fine, but the next `noctalia-sync` run can
overwrite it. The zsh aliases `sync` and `update` call this workflow.

## System behavior worth knowing

- Boot: xanmod latest kernel, Plymouth, quiet boot; Limine is enabled on `apollo`
  through `modules/core/common/system/os/loader.nix`.
- Networking: iwd with IPv6 disabled, NetworkManager off, dhcpcd off by default,
  dnscrypt-proxy on `127.0.0.1`, systemd-resolved and resolvconf disabled, nftables
  firewall on.
- Privilege: `modules/core/common/system/os/doas.nix` disables sudo and enables passwordless doas
  for `wheel`; the `workstation` role turns this on.
- Audio: PipeWire with ALSA, JACK, Pulse, and WirePlumber when
  `modules.device.hasSound` is true.
- GPU: NVIDIA proprietary driver with modesetting/fine-grained power management and
  optional PRIME offload; Intel i915 GuC and VA-API packages when Intel GPU is on.
- Laptop: zram swap and undervolt/thermald/power-profiles-daemon via the `laptop`
  role.
- ISO: `hosts/iso/live.nix` wraps Calamares with a Wayland/pkexec launcher, forces
  xanmod, switches to dhcpcd, disables NetworkManager/wireless, enables broad
  polkit rules, and adds installer/debootstrap tooling. Do not “clean up” this file
  without testing the ISO build and boot path.
- `modules/core/common/system/os/debloat.nix` deliberately masks or disables ModemManager,
  nscd, core dumps, timesyncd, speechd, and some systemd sockets/timers. That is
  intentional; do not re-enable them as “fixes” unless the task asks for it.

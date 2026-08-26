<!-- markdownlint-disable MD013 -->
<!-- accidentally installed lint for markdown lol -->

# NixOS Configuration

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
![NixOS](https://img.shields.io/badge/NixOS-unstable-5277C3?logo=nixos&logoColor=white)

A NixOS configuration, that follows [dendritic](https://github.com/mightyiam/dendritic)

## Hosts

| Host     | Target                         | Description                                                                                    |
| -------- | ------------------------------ | ---------------------------------------------------------------------------------------------- |
| `victus` | `.#nixosConfigurations.victus` | Daily driver laptop: Intel iGPU + NVIDIA dGPU (PRIME offload), user `ar175`                    |
| `iso`    | `.#nixosConfigurations.iso`    | Rescue/installer ISO: greetd auto-login into niri + noctalia, fish, calamares + recovery tools |

## Install

Boot any NixOS ISO, then:

```bash
git clone https://github.com/ar175-lol/nixos-config.git && cd nixos-config
sudo nix --experimental-features "nix-command flakes" \
    run github:nix-community/disko -- --mode disko disko/victus.nix
sudo nix --experimental-features "nix-command flakes" \
    run github:nix-community/disko -- --mode mount disko/victus.nix
sudo nixos-install --root /mnt --flake github:ar175-lol/nixos-config#victus
reboot
```

## Daily driving

Rebuilds go through [`nh`](https://github.com/nix-community/nh):

```bash
nh os switch              # apply current working tree
sync                      # alias: stage changes, regenerate flake.nix, switch
update                    # same, but updates flake.lock first
clean                     # nh clean all
```

More in [docs/](docs/): [architecture](docs/architecture.md),
[usage](docs/usage.md), [contributing](docs/contributing.md).

## Screenshots

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/0b783426-9afa-4c27-8105-4f41e31e4447" />

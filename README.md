# Not overengineered NixOS configuration
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A simple, straightforward NixOS configuration that follows a [dendritic pattern]().

This configuration uses the following software stack:

| Component | Role / Description | Managed / Configured Via |
| :--- | :--- | :--- |
| [niri]() | Wayland compositor | [nix-wrapper-modules]() |
| [noctalia]() | Desktop shell (notifications, status bar, etc.) | [nix-wrapper-modules]() |
| [foot]() + [zsh]() + [starship]() | Terminal environment | NixOS options + [nix-wrapper-modules]() |
| [neovim]() | Main text editor | [nvf]() |
| [Zen Browser]() | Primary web browser | [zen-browser-flake]() |
*And a lot of things, but I forgot them...*

> [!NOTE]
> This configuration may contain some anti-patterns (see [dendritic anti-patterns]()).
> But ~I don't care~ I am happy to **merge** your fixes.

## Hosts
| Hostname | Description |
| :-------------- | :--------------- |
| `victus` | Main host |
| `iso` | In case of ~nuclear war~ big boom (iso) |

## Usage
![WIP](https://media.makeameme.org/created/wip-wip-everywhere-5c2671.jpg)

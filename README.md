<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD013 -->

# Not overengineered NixOS configuration

[![License: MIT](https://shields.io/badge/License-MIT-blue.svg)][mit-url]

A simple, straightforward NixOS configuration that follows a
[dendritic pattern][dendritic-url].

This configuration uses the following software stack:

| Component                                                    | Description                                     | Configured Via                                     |
| :----------------------------------------------------------- | :---------------------------------------------- | :------------------------------------------------- |
| [niri][niri-url]                                             | Wayland compositor                              | [nix-wrapper-modules][wrapper-url]                 |
| [noctalia][noctalia-url]                                     | Desktop shell (notifications, status bar, etc.) | [nix-wrapper-modules][wrapper-url]                 |
| [foot][foot-url] + [zsh][zsh-url] + [starship][starship-url] | Terminal environment                            | NixOS options + [nix-wrapper-modules][wrapper-url] |
| [neovim][neovim-url]                                         | Main text editor                                | [nvf][nvf-url]                                     |
| [Zen Browser][zen-url]                                       | Primary web browser                             | [zen-browser-flake][zen-flake-url]                 |

_And many other things that I probably forgot..._

> [!NOTE]
> This configuration may contain some anti-patterns (see
> [dendritic anti-patterns][anti-patterns-url]). But ~~I don't care~~ I am happy
> to **merge** your fixes.

## Hosts

| Hostname | Description                        |
| :------- | :--------------------------------- |
| `victus` | Main host                          |
| `iso`    | In case of a ~~nuclear war~~ (iso) |

## Usage

### niri binds

Configured in `modules/ar175/niri/binds.nix`

<details>
  <summary>Focus & window movement</summary>

| Combination          | Action            |
| :------------------- | :---------------- |
| `Mod` + `H`          | Focus left        |
| `Mod` + `L`          | Focus right       |
| `Mod` + `J`          | Focus down        |
| `Mod` + `K`          | Focus up          |
| `Mod` + `Ctrl` + `H` | Move column left  |
| `Mod` + `Ctrl` + `J` | Move window down  |
| `Mod` + `Ctrl` + `K` | Move window up    |
| `Mod` + `Ctrl` + `L` | Move column right |

</details>

<details>
  <summary>Window resize</summary>

| Combination         | Action                        |
| :------------------ | :---------------------------- |
| `Mod` + `Alt` + `H` | Decrease column width (-10%)  |
| `Mod` + `Alt` + `J` | Decrease window height (-10%) |
| `Mod` + `Alt` + `K` | Increase window height (+10%) |
| `Mod` + `Alt` + `L` | Increase column width (+10%)  |
| `Mod` + `Comma`     | Consume window into column    |
| `Mod` + `Period`    | Expel window from column      |

</details>

<details>
  <summary>Opening apps</summary>

| Combination      | Action                         |
| :--------------- | :----------------------------- |
| `Mod` + `Return` | Launch main terminal (`foot`)  |
| `Mod` + `D`      | Toggle app launcher panel      |
| `Mod` + `V`      | Toggle clipboard history panel |

</details>

## Credits

Thank you:

- [mightyiam][mightyiam-url] for creating the dendritic pattern.

[mit-url]: https://opensource.org/license/mit/
[dendritic-url]: https://github.com/mightyiam/dendritic
[anti-patterns-url]: https://github.com/mightyiam/dendritic#anti-patterns
[mightyiam-url]: https://github.com/mightyiam
[niri-url]: https://github.com/YaLTeR/niri
[noctalia-url]: https://github.com/noctalia-dev/noctalia
[wrapper-url]: https://github.com/BirdeeHub/nix-wrapper-modules
[foot-url]: https://codeberg.org/dnkl/foot
[zsh-url]: https://www.zsh.org/
[starship-url]: https://starship.rs/
[neovim-url]: https://github.com/neovim/neovim
[nvf-url]: https://github.com/NotAShelf/nvf
[zen-url]: https://zen-browser.app/
[zen-flake-url]: https://github.com/0xc000022070/zen-browser-flake

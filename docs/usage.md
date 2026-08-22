# Usage

## Rebuilding

Via [`nh`](https://github.com/nix-community/nh):

| Command        | Action                                              |
|----------------|-----------------------------------------------------|
| `nh os switch` | Apply the current working tree                      |
| `sync`         | `git add .` + regenerate `flake.nix` + switch       |
| `update`       | Same as `sync`, but bumps `flake.lock` first        |
| `clean`        | `nh clean all`                                      |


## niri keys (`modules/ar175/niri/binds.nix`, overlay: `Mod+/`)

| Keys                     | Action                                        |
|--------------------------|-----------------------------------------------|
| `Mod+H/J/K/L`            | Focus left / down / up / right                |
| `Mod+Ctrl+H/J/K/L`       | Move window/column                            |
| `Mod+Return` / `Mod+Q`   | Terminal / close window                       |
| `Mod+F` / `Mod+Space`    | Maximize / toggle floating                    |
| `Mod+Grave`              | Overview                                      |
| `Mod+Comma` / `Mod+.`    | Consume into column / expel from column       |
| `Mod+1..9`               | Focus workspace                               |
| `Mod+Shift+1..9`         | Move column to workspace                      |
| `Mod+D` / `Mod+V`        | Noctalia launcher / clipboard                 |
| `Mod+Shift+S`            | Screenshot (to clipboard)                     |

Layout is `us,ru` via `Alt+Shift`; touchpad uses clickfinger + natural scroll.

## tmux

Prefix `C-a`, vi mode, mouse on. `Alt+c` new window, `Alt+x` kill, `Alt+1..9` jump,
`prefix r` reload.

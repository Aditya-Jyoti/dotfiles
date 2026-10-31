# dotfiles

bspwm · sxhkd · polybar · picom · rofi · dunst · alacritty · tmux · nvim — every colour generated from the wallpaper by **matugen**.

## Install

```sh
git clone <this repo> ~/dotfiles && cd ~/dotfiles
./install.sh          # stow everything (./install.sh -n for a dry run)
./install.sh nvim     # or just some packages
```

Each top-level directory is a [stow](https://www.gnu.org/software/stow/) package mirroring `$HOME` (`nvim/.config/nvim` → `~/.config/nvim`).

## Theming

| Do | How |
|---|---|
| Pick wallpaper + recolour everything | `super + w` (or `setwall <image>` / `setwall --random`) |
| Light ↔ dark | `super + shift + w` (or `setwall --mode toggle`) |
| Re-apply colours to running apps | `~/.config/matugen/scripts/theme-reload` |
| Different palette style | `MATUGEN_TYPE=scheme-tonal-spot setwall` |
| Different source colour | `MATUGEN_PREFER=saturation setwall` |

Scripts live in `bin/.local/bin/` (on `$PATH`). Templates in `matugen/.config/matugen/templates/` → outputs mostly in `~/.cache/matugen/` (not tracked).

Themed: polybar, rofi, dunst, bspwm borders, alacritty, tmux, nvim, yazi, btop, GTK 3/4, flameshot, VS Code, Firefox, Dark Reader.
Needs restart to pick up: btop, Firefox, GTK apps. GTK3 needs the `adw-gtk3` theme to follow fully.

## Layout

| Package | Notes |
|---|---|
| `bspwm` | monitor setup (laptop eDP + any external), autostart, rules |
| `sxhkd` | keybinds |
| `polybar` | `launch.sh` picks `bar/laptop` (compact) or `bar/monitor` (roomy) per output |
| `picom` | glx, v13 animations, blur only behind translucent windows |
| `matugen` | colour config + templates |
| `bin` | scripts → `~/.local/bin`: `setwall`, `theme-reload`, `screenlock`, `shot`, `term`, `scratchpad`, `lazygit-scratch`, `workspace-switcher`, `tmux-session-picker`, `save-session`, `volume-control`, `brightness-control`, `rofi-calculator` |
| `alacritty` `tmux` `nvim` `rofi` `dunst` `yazi` `btop` `flameshot` `lazygit` `git` `greenclip` | app configs |

## Not tracked
Generated colour files, logs, yazi plugins (`ya pkg install` restores them), `.backup-*/`.
Machine-specific tools in `~/.local/bin` (kubectl, graph-easy, uv/pipx shims) stay unmanaged.

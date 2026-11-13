# dotfiles

bspwm · sxhkd · polybar · picom · rofi · dunst · alacritty · zellij · nvim — every colour generated from the wallpaper by **matugen**.

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
| Fixed theme for this wallpaper | `super + alt + w` (or `setwall --theme gruvbox`; `--theme auto` to undo) |
| Re-apply colours to running apps | `theme-reload` |
| Different palette style | `MATUGEN_TYPE=scheme-tonal-spot setwall` |
| Different source colour | `MATUGEN_PREFER=saturation setwall` |

Fixed themes (gruvbox, nord, ayu, everforest, catppuccin — each dark + light) are palettes in
`matugen/.config/matugen/themes.toml`; `matugen-theme` expands them into a full scheme so every
template works. Which wallpaper uses which theme is remembered in `matugen/.config/matugen/wallpaper-themes`.
Add a theme by adding a `[name.dark]` + `[name.light]` block.

Scripts live in `bin/.local/bin/` (on `$PATH`). Templates in `matugen/.config/matugen/templates/` → outputs mostly in `~/.cache/matugen/` (not tracked).

Themed: polybar, rofi, dunst, bspwm borders, alacritty, zellij, tmux, nvim, yazi, btop, cava, GTK 3/4, flameshot, VS Code, Firefox, Dark Reader.
Needs restart to pick up: btop, Firefox, GTK apps. GTK3 needs the `adw-gtk3` theme to follow fully.

## Layout

| Package | Notes |
|---|---|
| `bspwm` | autostart, rules; monitor layout comes from `displays` (super + shift + d: extend / mirror / one screen, remembered) |
| `sxhkd` | keybinds |
| `polybar` | `launch.sh` picks `bar/laptop` (compact) or `bar/monitor` (roomy) per output |
| `picom` | glx, v13 animations, blur only behind translucent windows |
| `matugen` | colour config + templates |
| `bin` | scripts → `~/.local/bin`: `setwall`, `matugen-theme`, `theme-reload`, `screenlock`, `shot`, `term`, `scratchpad`, `lazygit-scratch`, `workspace-switcher`, `tmux-session-picker`, `save-session`, `volume-control`, `brightness-control`, `rofi-calculator`, `clipboard`, `displays`, `calendar-popup`, `calendar-tui` |
| `alacritty` `zellij` `tmux` `nvim` `rofi` `dunst` `yazi` `btop` `flameshot` `lazygit` `git` `greenclip` | app configs |
| `applications` | launcher entries (rofi `alt + space`), e.g. Calendar |
| `wireplumber` | audio: headphones/speakers and monitor (HDMI/DP) available as outputs at the same time |
| `cava` | audio visualizer; colours from matugen (`themes/matugen`), reloads live on wallpaper change |
| `wallpapers` | `~/.wallpapers` (picked with `super + w`) |
| `khal` `vdirsyncer` | calendar behind the polybar clock (click it); CalDAV setup steps are in the vdirsyncer config |

## Zellij (laptop + servers)

One self-contained `config.kdl`: no prefix key, starts locked so nvim/shell
keys pass through, gruvbox fallback theme built in (matugen overrides it on
the laptop). Key cheat-sheet is at the top of the file.

On a server:

```sh
git clone https://github.com/Aditya-Jyoti/dotfiles ~/dotfiles
cd ~/dotfiles && stow -t ~ zellij        # or: ./install.sh zellij
```

Inside local zellij, sshing into a server running zellij asks whether to
hand keys to the nested session (`nested_session_handling "ask"`).

## Not tracked
Generated colour files, logs, yazi plugins (`ya pkg install` restores them), `.backup-*/`.
Machine-specific tools in `~/.local/bin` (kubectl, graph-easy, uv/pipx shims) stay unmanaged.

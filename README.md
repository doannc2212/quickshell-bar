# my quickshell config

this is my personal Hyprland desktop config built with [Quickshell](https://quickshell.outfoxxed.me/) — a status bar, app launcher, and notification daemon. it uses the Tokyo Night color scheme because i like it.

feel free to look around, borrow ideas, or use it as a starting point for your own. no pressure — it's just how i like my desktop.

## what's in it

- clock & date
- hyprland workspace indicator
- active window title
- system info (cpu, memory, network, battery, temperature)
- system tray
- app launcher (rofi drun-style)
- notification popups (dunst-style)
- theme switcher (15 themes across 3 families)

<img width="1920" height="111" alt="image" src="https://github.com/user-attachments/assets/06d824ae-cf21-4c78-919c-1604f1c0a2dc" />
<br/>
<img width="405" height="146" alt="image" src="https://github.com/user-attachments/assets/40c9b11a-abf2-4e9b-bf85-ec44ea67d69d" />
<br/>
<img width="601" height="495" alt="image" src="https://github.com/user-attachments/assets/40c46613-dc24-461a-9075-33ffea221716" />


## structure

```
shell.qml                       # entry point
components/Bar.qml              # bar layout, one per screen
components/AppLauncher.qml      # app launcher overlay
components/NotificationPopup.qml # notification popups
components/ThemeSwitcher.qml    # theme picker overlay
widgets/                        # ui pieces (clock, workspaces, etc.)
services/                       # data providers (time, system info, notifications, theme)
```

## dependencies

- [Quickshell](https://quickshell.outfoxxed.me/) + Qt 6
- Hyprland
- a Nerd Font (i use Hack Nerd Font)
- `top`, `free`, `nmcli`, `sensors` for system info

## running

```bash
quickshell
```

it reads from `~/.config/quickshell/` by default.

## app launcher

a rofi drun-style launcher built into the shell. toggle it via IPC:

```bash
qs ipc call launcher toggle
```

bind it in `hyprland.conf`:

```
bind = SUPER, D, exec, qs ipc call launcher toggle
```

features:
- searches by app name, description, keywords, and categories
- keyboard navigation (arrow keys, enter, escape)
- click backdrop to dismiss

## notifications

a built-in notification daemon — replaces dunst/mako. popups appear in the top-right corner with urgency-based styling and auto-expire timers.

IPC commands:

```bash
qs ipc call notifications dismiss_all   # dismiss all popups
qs ipc call notifications dnd_toggle    # toggle do not disturb
```

features:
- urgency-based accent colors (critical, normal, low)
- app icons for common apps (discord, firefox, spotify, etc.)
- action buttons from the notification
- progress bar showing time until auto-dismiss
- click to dismiss, close button per notification
- max 5 visible notifications at a time
- do not disturb mode

**note:** only one notification daemon can run on D-Bus at a time — stop dunst/mako before using this.

## theme switcher

a built-in theme picker with 15 themes across 3 families. toggle it via IPC:

```bash
qs ipc call theme toggle
```

bind it in `hyprland.conf`:

```
bind = SUPER, T, exec, qs ipc call theme toggle
```

available themes:
- **Tokyo Night** — Night, Storm, Moon, Light
- **Catppuccin** — Mocha, Macchiato, Frappe, Latte
- **Beared** — Arc, Surprising Eggplant, Oceanic, Solarized Dark, Coffee, Monokai Stone, Vivid Black

features:
- color swatches preview for each theme
- keyboard navigation (arrow keys, enter, escape)
- click backdrop to dismiss
- selected theme persists across restarts (saved to `~/.config/quickshell/theme.conf`)
- all components update instantly with smooth color transitions

## tweaking

- **colors** — all colors are centralized in `services/Theme.qml`. select a theme via the theme switcher, or add your own by appending to the `themes` array.
- **font** — search for `"Hack Nerd Font"` and swap it with yours.
- **layout** — rearrange widgets in `components/Bar.qml`.
- **polling rate** — change the interval in `services/SystemInfo.qml` (default 2s).

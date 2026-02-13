# my quickshell bar

this is my personal status bar config for [Hyprland](https://hyprland.org/), built with [Quickshell](https://quickshell.outfoxxed.me/). it uses the Tokyo Night color scheme because i like it.

feel free to look around, borrow ideas, or use it as a starting point for your own. no pressure — it's just how i like my desktop.

## what's in it

- clock & date
- hyprland workspace indicator
- active window title
- system info (cpu, memory, network, battery, temperature)
- system tray
<img width="1920" height="268" alt="image" src="https://github.com/user-attachments/assets/93107304-d012-4923-a06b-e37a8d5cf041" />


## structure

```
shell.qml              # entry point
components/Bar.qml     # bar layout, one per screen
widgets/               # ui pieces (clock, workspaces, etc.)
services/              # data providers (polling system info, time)
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

## tweaking

- **colors** — edit the hex values in widget files. the main background is `#1a1b26`.
- **font** — search for `"Hack Nerd Font"` and swap it with yours.
- **layout** — rearrange widgets in `components/Bar.qml`.
- **polling rate** — change the interval in `services/SystemInfo.qml` (default 2s).

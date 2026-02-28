# 🌿 Sprigatito Rice — dotfiles

> *Soft greens · cream · dark charcoal · cozy forest vibes*

KDE Plasma 6 rice themed around the Pokémon **Sprigatito**.

## Palette

| Name | Hex |
|------|-----|
| Leaf Green | `#7BC96F` |
| Mint Green | `#A8E6CF` |
| Cream | `#F5F3E7` |
| Brown Accent | `#8B5E3C` |
| Dark Charcoal | `#1E1E2E` |

## What's included

| Directory | Contents |
|-----------|----------|
| `kitty/` | Kitty terminal config + startup script + Sprigatito art |
| `starship/` | Starship prompt (cozy forest theme) |
| `fastfetch/` | Fastfetch config + Sprigatito ASCII art |
| `kvantum/` | Kvantum Qt theme (Sprigatito) |
| `kde/` | KDE colour scheme, plasma theme, plasmoids, kwinrc, kdeglobals, etc. |
| `gtk/` | GTK 3 + GTK 4 settings |
| `local-bin/` | Custom commands: `helpme`, `tryhackme`, `ididanoopsie`, `sprigatito-says` |
| `bashrc-sprigatito.sh` | Bash aliases + PATH additions |

## Prerequisites

```bash
yay -S kvantum ttf-jetbrains-mono-nerd papirus-icon-theme papirus-folders \
        nwg-look kitty starship fastfetch obsidian
```

## Install

```bash
git clone https://github.com/TheOnlyOrchid/dotfiles ~/dotfiles
cd ~/dotfiles
bash install.sh
```

## Custom commands

Run `helpme` in the terminal for a full guide. Quick reference:

| Command | What it does |
|---------|-------------|
| `helpme` | This, but prettier |
| `tryhackme [N]` | Opens TryHackMe + Obsidian on workspace N (default: 2) |
| `tryhackme update "msg"` | Commits + pushes cybernotes |
| `ididanoopsie` | Resets the days-since-incident counter |
| `sprigatito-says` | Wisdom |
| `please` | sudo |
| `oops` | `git commit --amend --no-edit` |
| `yeet <path>` | `rm -rf` with a conscience |

## Desktop widget

Add the **"Days Since Last Incident"** widget from the plasmoids directory to your desktop via:
*Right-click desktop → Add Widgets → search "Days Since Last Incident"*

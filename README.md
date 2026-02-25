# MonarchDots

[![GitHub](https://img.shields.io/badge/GitHub-MonarchDots-black?logo=github)](https://github.com/Cypher-Monarch/MonarchDots)
[![OS](https://img.shields.io/badge/Works%20on-Arch%20Linux-blue?logo=arch-linux)]()
[![License](https://img.shields.io/badge/License-MIT-gold)](LICENSE)

**A curated collection of Hyprland-centric dotfiles — clean, minimal, fast.**

---

> *“Why spend time looking at a boring desktop, when you can look at a pretty one.”*

MonarchDots bundles all configs that shape a cohesive Wayland environment: smooth animations, sharp fonts, responsive bars, tidy notifications, and a consistent workflow.

The setup is reproducible from a fresh install using a bootstrap script.

---

## ✨ What’s Inside

* 🌀 Hyprland — window manager
* 🔒 Hyprlock — lockscreen
* 🪟 Waybar — status bar
* 🌄 Waypaper — wallpaper manager
* 🔊 Cava — audio visualizer
* 🐇 Eww — widgets
* 🔍 Fuzzel — launcher
* 🖥️ Kitty — terminal
* 🧊 Rofi — menus
* 🔔 SwayNC — notifications
* 📦 nwg-dock-hyprland — dock
* 🚪 Wlogout — logout screen
* 🧩 Scripts — power, screenshots, wallpaper, utilities

Shell setup is included for convenience:
Powerlevel10k, Zinit, FZF, Gruvbox LS_COLORS, and Pyenv.

---

## 🚀 Installation

### Quick Install (Recommended)

Run the bootstrap installer:

```bash
curl -fsSL https://github.com/Cypher-Monarch/MonarchDots/releases/latest/download/bootstrap-v1.0.sh | bash
```

This will:

* Install required packages
* Copy all configs
* Enable essential services
* Optionally install Chaotic-AUR
* Optionally apply the GRUB theme

Reboot or restart your session after installation.

---

### Manual Install

Clone the repository:

```bash
git clone https://github.com/Cypher-Monarch/MonarchDots
```

Copy configs:

```bash
rsync -a MonarchDots/home/ ~/
```

Install required packages manually.

---

## 🧠 Design Philosophy

MonarchDots aims to be:

* Minimal but complete
* Fast and responsive
* Visually consistent
* Reproducible from a fresh install

The goal is a system that feels cohesive rather than a loose collection of configs.

---

## 🔧 Requirements

* Arch Linux
* Wayland / Hyprland
* PipeWire + WirePlumber
* Nerd Fonts

The bootstrap installer handles most of this automatically.

---

## 📸 Screenshots

![Screenshot 1](https://cypher-monarch.github.io/arsenal/assets/hypr1-bare.png)
![Screenshot 2](https://cypher-monarch.github.io/arsenal/assets/hypr2-bare.png)
![Screenshot 3](https://cypher-monarch.github.io/arsenal/assets/hypr3-bare.png)
![Screenshot 4](https://cypher-monarch.github.io/arsenal/assets/hypr4-bare.png)
![Screenshot 5](https://cypher-monarch.github.io/arsenal/assets/hypr5-bare.png)

---

## 📜 License

MIT — feel free to reuse anything.

---

## 🛣️ Roadmap

Planned improvements and ideas for future versions:

* Improve bootstrap script reliability and detection
* Automatic monitor and resolution profiles
* Dynamic wallpaper / theme switching
* More Waybar themes and layout presets
* Better laptop vs desktop power profile handling
* Optional minimal install mode
* Performance tuning and startup optimization

Long-term ideas:

* Multi-distro bootstrap support
* Automatic GPU detection (Intel / AMD / NVIDIA)
* Theming presets selectable during install


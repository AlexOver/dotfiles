# dotfiles

Personal Arch Linux dotfiles, provisioned with Ansible.

## Usage

```sh
./bootstrap.sh
```

This runs `ansible-playbook -i hosts dotfiles.yml --ask-become-pass`, applying every role below in order.

To run a single role, use its tag:

```sh
ansible-playbook -i hosts dotfiles.yml --ask-become-pass --tags <tag>
```

## Roles

| Tag | What it does |
|-----|--------------|
| `requirements` | Base packages needed across the rest of the setup |
| `hyprland` | Hyprland/Wayland ecosystem, wallpapers |
| `yay` | yay (AUR helper) |
| `waybar` | Waybar status bar config |
| `scripts` | Personal shell scripts (e.g. `tmux_sessionizer`) |
| `kitty` | Kitty terminal config and JetBrains Mono Nerd Font |
| `zsh` | ZSH, oh-my-posh prompt, fzf |
| `tmux` | tmux config |
| `neovim` | Neovim (built from source), LazyVim, lazygit |

Files ending in `.link` are symlinked from this repo into place, so edits to them are tracked directly in git. Files without that suffix (e.g. `custom.lua`) are copied once on first run and left alone afterward, for per-machine customization that shouldn't be tracked.

# Quick Start Guide

## First Time Setup (New Machine)

```bash
# 1. Clone the repo
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# 2. Run the installer
cd ~/dotfiles
./install.sh

# 3. Restart terminal
# Then press Ctrl-A + Shift-I in tmux to install plugins
```

## Updating from Git

```bash
cd ~/dotfiles
git pull
stow -R zsh tmux starship wezterm aerospace
```

## Common Stow Commands

```bash
# Stow (create symlinks)
stow zsh

# Unstow (remove symlinks)
stow -D zsh

# Restow (useful after updates)
stow -R zsh

# Stow all packages at once
stow */

# See what would happen without doing it
stow -n zsh
```

## Key Bindings

### Tmux (prefix: Ctrl-A)
- `prefix + I` - Install plugins
- `prefix + c` - New window
- `prefix + ,` - Rename window
- `prefix + 1-9` - Switch to window
- `prefix + %` - Split vertically
- `prefix + "` - Split horizontally

### Aerospace (i3-like)
- `Alt + H/J/K/L` - Focus window (vim style)
- `Alt + 1/2/3/4` - Switch workspace
- `Alt + Shift + 1/2/3/4` - Move window to workspace
- `Alt + G` - Open Chrome
- `Alt + W` - Open WezTerm
- `Alt + R` - Open Cursor
- `Alt + C` - Open Claude

### WezTerm
- `Ctrl + Q` - Toggle fullscreen
- `Ctrl + '` - Clear scrollback
- `Ctrl + Click` - Open link

## Troubleshooting

### Stow says "existing target is not a symlink"
Your file already exists. Either backup and remove it, or use `--adopt`:
```bash
stow --adopt zsh
```

### Can't find stow command
```bash
brew install stow
```

### Tmux plugins not working
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then in tmux: Ctrl-A + Shift-I
```

### Changes not taking effect
```bash
source ~/.zshrc
# Or restart your terminal
```

## File Locations

- Zsh: `~/.zshrc`
- Tmux: `~/.tmux.conf`
- Starship: `~/.config/starship.toml`
- WezTerm: `~/.config/wezterm/wezterm.lua`
- Aerospace: `~/.config/aerospace/aerospace.toml`

All are symlinks pointing to `~/dotfiles/<package>/...`

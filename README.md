# Dotfiles

My personal development environment configuration for macOS, managed with GNU Stow.

## What's Included

- **Zsh** - Shell configuration with custom plugins
- **Tmux** - Terminal multiplexer with TPM and Catppuccin theme
- **Starship** - Fast, customizable prompt with Catppuccin Mocha theme
- **WezTerm** - GPU-accelerated terminal emulator
- **Aerospace** - i3-like tiling window manager for macOS

## Prerequisites

- macOS (tested on macOS Sequoia)
- Git (usually pre-installed on macOS)

The installation script will automatically install:
- Homebrew (if not present)
- GNU Stow
- All required applications and dependencies

## Quick Start

### Fresh Installation

On a new machine, clone this repository and run the installation script:

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# Navigate to the directory
cd ~/dotfiles

# Run the installation script
./install.sh
```

The script will:
1. Check your system and install Homebrew if needed
2. Install GNU Stow for symlink management
3. Backup any existing dotfiles to `~/.dotfiles_backup_<timestamp>`
4. Install all required applications (Starship, Tmux, Aerospace, WezTerm)
5. Set up Zsh plugins (autosuggestions, syntax highlighting, completions)
6. Create symlinks using GNU Stow
7. Set Zsh as your default shell (if not already)

### Post-Installation

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Install Tmux plugins**: Open tmux and press `Ctrl-A` + `Shift-I` to install plugins via TPM

3. **Configure Aerospace**: If you want Aerospace to start at login, enable it in System Settings

4. **Font Installation**: For the best experience, install a Nerd Font (JetBrains Mono is configured in WezTerm):
   ```bash
   brew tap homebrew/cask-fonts
   brew install --cask font-jetbrains-mono-nerd-font
   ```

## Manual Management

If you prefer to manage dotfiles manually without the install script:

### Stowing Individual Packages

```bash
cd ~/dotfiles
stow zsh      # Links .zshrc
stow tmux     # Links .tmux.conf
stow starship # Links .config/starship.toml
stow wezterm  # Links .config/wezterm/wezterm.lua
stow aerospace # Links .config/aerospace/aerospace.toml
```

### Unstowing (Removing Symlinks)

```bash
cd ~/dotfiles
stow -D zsh   # Removes .zshrc symlink
stow -D tmux  # Removes .tmux.conf symlink
# etc.
```

### Restowing (Useful After Updates)

```bash
cd ~/dotfiles
stow -R zsh   # Restows .zshrc
```

## How It Works

This dotfiles setup uses **GNU Stow**, a symlink farm manager that creates symbolic links from your home directory to files in this repository.

### Directory Structure

Each subdirectory represents a "package" that mirrors the structure from your home directory:

```
dotfiles/
├── zsh/
│   └── .zshrc                          → ~/.zshrc
├── tmux/
│   └── .tmux.conf                      → ~/.tmux.conf
├── starship/
│   └── .config/
│       └── starship.toml               → ~/.config/starship.toml
├── wezterm/
│   └── .config/
│       └── wezterm/
│           └── wezterm.lua             → ~/.config/wezterm/wezterm.lua
└── aerospace/
    └── .config/
        └── aerospace/
            └── aerospace.toml          → ~/.config/aerospace/aerospace.toml
```

When you run `stow zsh`, it creates a symlink at `~/.zshrc` pointing to `~/dotfiles/zsh/.zshrc`.

## Configuration Details

### Zsh

- **Plugins**:
  - zsh-autosuggestions (history-based command suggestions)
  - zsh-syntax-highlighting (syntax highlighting for commands)
  - zsh-completions (additional completion definitions)
- **Path configurations** for NVM, Conda, Homebrew, Java, PostgreSQL
- **Starship prompt** integration

### Tmux

- **Prefix**: `Ctrl-A` (instead of default `Ctrl-B`)
- **Mouse support** enabled
- **Plugins** (managed by TPM):
  - tmux-sensible (sensible defaults)
  - tmux-yank (clipboard integration)
  - tmux-resurrect (save/restore sessions)
  - tmux-continuum (automatic session saving)
  - tmux-thumbs (keyboard-based selection)
  - tmux-fzf (fuzzy finder integration)
  - tmux-fzf-url (URL opener)
- **Theme**: Catppuccin
- **Status bar** at top with directory and time

### Starship

- **Theme**: Catppuccin Mocha
- **Minimal left prompt** showing directory
- **Right-aligned modules** for git, status, and other info
- **Fast performance** with 1000ms command timeout

### WezTerm

- **Color scheme**: Catppuccin Mocha
- **Font**: JetBrains Mono, 13pt
- **Window transparency** with blur effect
- **Custom keybindings**:
  - `Ctrl-Q`: Toggle fullscreen
  - `Ctrl-'`: Clear scrollback
  - `Ctrl-Click`: Open links

### Aerospace

- **i3-like tiling** window manager for macOS
- **Workspaces**: 4 workspaces with vim-style navigation
- **Keybindings**:
  - `Alt-H/J/K/L`: Focus windows (vim-style)
  - `Alt-Shift-H/J/K/L`: Move windows
  - `Alt-1/2/3/4`: Switch workspaces
  - `Alt-Shift-1/2/3/4`: Move window to workspace
  - `Alt-G/R/S/W/C`: Quick launch apps (Chrome, Cursor, Slack, WezTerm, Claude)

## Updating Dotfiles

### On Your Main Machine

1. Make changes to your dotfiles
2. Test them
3. Commit and push to GitHub:
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Update configuration"
   git push
   ```

### On Other Machines

```bash
cd ~/dotfiles
git pull
stow -R zsh tmux starship wezterm aerospace
```

## Troubleshooting

### Stow Conflicts

If Stow reports conflicts, you likely have existing files. Options:

1. **Let the install script backup files** (recommended for first install)
2. **Manually backup and remove** the conflicting files
3. **Use `--adopt` flag** to adopt existing files into the repo:
   ```bash
   stow --adopt zsh
   git diff  # Check what changed
   git restore .  # Restore repo version if you want to keep it
   ```

### Missing Dependencies

If applications aren't installed, manually install them:

```bash
brew install starship tmux stow
brew install --cask wezterm
brew install --cask nikitabobko/tap/aerospace
```

### Tmux Plugins Not Working

Install TPM and plugins manually:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
# Inside tmux, press Ctrl-A + Shift-I
```

### Zsh Plugins Not Loading

Install them manually:

```bash
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.zsh/zsh-completions
```

## Customization

Feel free to fork this repository and customize it for your needs:

1. **Fork** the repository on GitHub
2. **Clone** your fork: `git clone https://github.com/yourusername/dotfiles.git`
3. **Modify** the configurations
4. **Test** your changes locally
5. **Commit and push** your customizations

### Adding New Configurations

To add a new configuration file:

1. Create a new directory in `~/dotfiles/`
2. Mirror the structure from your home directory
3. Move your config file into the appropriate location
4. Stow it: `stow <package-name>`

Example for adding Neovim:

```bash
mkdir -p ~/dotfiles/nvim/.config/nvim
mv ~/.config/nvim/init.lua ~/dotfiles/nvim/.config/nvim/
cd ~/dotfiles
stow nvim
```

## Security Note

This repository contains personal configuration files. Before making your dotfiles public:

- Remove or encrypt sensitive information (API keys, tokens, etc.)
- Use `.gitignore` to exclude files with secrets
- Consider using a tool like `git-crypt` for sensitive files
- Review your `.zshrc` for hardcoded credentials or paths

## Resources

- [GNU Stow Documentation](https://www.gnu.org/software/stow/manual/stow.html)
- [Starship Documentation](https://starship.rs/)
- [Tmux Documentation](https://github.com/tmux/tmux/wiki)
- [WezTerm Documentation](https://wezfurlong.org/wezterm/)
- [Aerospace Documentation](https://nikitabobko.github.io/AeroSpace/guide)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)

## License

Feel free to use these dotfiles as inspiration for your own setup!

## Credits

These dotfiles are curated for my personal development workflow on macOS. Inspired by the Unix philosophy and the dotfiles community.

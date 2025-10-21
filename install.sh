#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
check_os() {
    print_info "Checking operating system..."
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS only."
        exit 1
    fi
    print_success "macOS detected"
}

# Check if Homebrew is installed
check_homebrew() {
    print_info "Checking for Homebrew..."
    if ! command -v brew &> /dev/null; then
        print_warning "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ $(uname -m) == 'arm64' ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        print_success "Homebrew is installed"
    fi
}

# Install GNU Stow
install_stow() {
    print_info "Checking for GNU Stow..."
    if ! command -v stow &> /dev/null; then
        print_warning "GNU Stow not found. Installing..."
        brew install stow
    else
        print_success "GNU Stow is installed"
    fi
}

# Backup existing dotfiles
backup_existing() {
    print_info "Backing up existing dotfiles..."
    BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"

    local backed_up=false

    # List of files to check
    local files=(
        "$HOME/.zshrc"
        "$HOME/.tmux.conf"
        "$HOME/.config/starship.toml"
        "$HOME/.config/wezterm/wezterm.lua"
        "$HOME/.config/aerospace/aerospace.toml"
    )

    for file in "${files[@]}"; do
        if [[ -e "$file" && ! -L "$file" ]]; then
            print_warning "Backing up: $file"
            mkdir -p "$(dirname "$BACKUP_DIR/${file#$HOME/}")"
            cp -r "$file" "$BACKUP_DIR/${file#$HOME/}"
            backed_up=true
        fi
    done

    if [[ "$backed_up" == true ]]; then
        print_success "Backup created at: $BACKUP_DIR"
    else
        print_info "No existing files to backup"
        rmdir "$BACKUP_DIR" 2>/dev/null || true
    fi
}

# Install required applications
install_apps() {
    print_info "Installing required applications and dependencies..."

    # Starship prompt
    if ! command -v starship &> /dev/null; then
        print_info "Installing Starship..."
        brew install starship
    fi

    # Tmux
    if ! command -v tmux &> /dev/null; then
        print_info "Installing Tmux..."
        brew install tmux
    fi

    # Install TPM (Tmux Plugin Manager)
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        print_info "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    # Aerospace (tiling window manager)
    if ! command -v aerospace &> /dev/null; then
        print_info "Installing Aerospace..."
        brew install --cask nikitabobko/tap/aerospace
    fi

    # WezTerm
    if [[ ! -d "/Applications/WezTerm.app" ]]; then
        print_info "Installing WezTerm..."
        brew install --cask wezterm
    fi

    # Zsh plugins
    print_info "Setting up Zsh plugins..."
    mkdir -p ~/.zsh

    if [[ ! -d "$HOME/.zsh/zsh-autosuggestions" ]]; then
        print_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    fi

    if [[ ! -d "$HOME/.zsh/zsh-syntax-highlighting" ]]; then
        print_info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
    fi

    if [[ ! -d "$HOME/.zsh/zsh-completions" ]]; then
        print_info "Installing zsh-completions..."
        git clone https://github.com/zsh-users/zsh-completions ~/.zsh/zsh-completions
    fi

    print_success "Applications installed"
}

# Stow dotfiles
stow_dotfiles() {
    print_info "Creating symlinks with GNU Stow..."
    cd "$DOTFILES_DIR"

    local packages=("zsh" "tmux" "starship" "wezterm" "aerospace")

    for package in "${packages[@]}"; do
        if [[ -d "$package" ]]; then
            print_info "Stowing $package..."
            stow -v "$package" 2>&1 | grep -v "BUG in find_stowed_path" || true
            print_success "$package stowed successfully"
        fi
    done
}

# Post-installation steps
post_install() {
    print_info "Running post-installation steps..."

    # Set Zsh as default shell if not already
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        print_info "Setting Zsh as default shell..."
        chsh -s "$(which zsh)"
        print_success "Zsh set as default shell (restart terminal for changes to take effect)"
    fi

    print_info "Installing Tmux plugins..."
    if [[ -f "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]]; then
        "$HOME/.tmux/plugins/tpm/bin/install_plugins"
    fi
}

# Main installation function
main() {
    echo ""
    echo "=========================================="
    echo "    Dotfiles Installation Script"
    echo "=========================================="
    echo ""

    check_os
    check_homebrew
    install_stow
    backup_existing
    install_apps
    stow_dotfiles
    post_install

    echo ""
    echo "=========================================="
    print_success "Installation complete!"
    echo "=========================================="
    echo ""
    print_info "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.zshrc"
    echo "  2. Open tmux and press 'prefix + I' (Ctrl-A + Shift-I) to install tmux plugins"
    echo "  3. Configure AeroSpace to start at login in System Settings if desired"
    echo ""
    print_warning "Note: Some changes may require a logout or restart to take full effect"
    echo ""
}

# Run main function
main

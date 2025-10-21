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

# Unstow dotfiles
unstow_dotfiles() {
    print_info "Removing symlinks with GNU Stow..."
    cd "$DOTFILES_DIR"

    local packages=("zsh" "tmux" "starship" "wezterm" "aerospace")

    for package in "${packages[@]}"; do
        if [[ -d "$package" ]]; then
            print_info "Unstowing $package..."
            stow -D "$package" 2>&1 | grep -v "BUG in find_stowed_path" || true
            print_success "$package unstowed successfully"
        fi
    done
}

# Main uninstallation function
main() {
    echo ""
    echo "=========================================="
    echo "    Dotfiles Uninstall Script"
    echo "=========================================="
    echo ""

    print_warning "This will remove all symlinks created by GNU Stow."
    print_warning "Your original backup files (if any) will remain untouched."
    echo ""
    read -p "Are you sure you want to continue? (y/N): " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Uninstall cancelled."
        exit 0
    fi

    unstow_dotfiles

    echo ""
    echo "=========================================="
    print_success "Uninstall complete!"
    echo "=========================================="
    echo ""
    print_info "Your dotfiles symlinks have been removed."
    print_info "If you had backups, they can be found in ~/.dotfiles_backup_*"
    print_info "To restore from backup, manually copy files back to their original locations."
    echo ""
    print_info "Note: Applications (tmux, starship, etc.) were NOT uninstalled."
    print_info "To remove them, run: brew uninstall tmux starship aerospace wezterm"
    echo ""
}

# Run main function
main

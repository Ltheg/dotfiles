#!/usr/bin/env bash

# Verification script to check if dotfiles are properly installed

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

check_symlink() {
    local target=$1
    local name=$2

    if [[ -L "$target" ]]; then
        echo -e "${GREEN}✓${NC} $name is symlinked"
        return 0
    elif [[ -e "$target" ]]; then
        echo -e "${YELLOW}⚠${NC} $name exists but is not a symlink"
        return 1
    else
        echo -e "${RED}✗${NC} $name not found"
        return 1
    fi
}

check_command() {
    local cmd=$1
    local name=$2

    if command -v "$cmd" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $name is installed"
        return 0
    else
        echo -e "${RED}✗${NC} $name is not installed"
        return 1
    fi
}

check_directory() {
    local dir=$1
    local name=$2

    if [[ -d "$dir" ]]; then
        echo -e "${GREEN}✓${NC} $name exists"
        return 0
    else
        echo -e "${RED}✗${NC} $name not found"
        return 1
    fi
}

echo "=========================================="
echo "    Dotfiles Verification"
echo "=========================================="
echo ""

echo "Checking symlinks..."
check_symlink "$HOME/.zshrc" "~/.zshrc"
check_symlink "$HOME/.tmux.conf" "~/.tmux.conf"
check_symlink "$HOME/.config/starship.toml" "~/.config/starship.toml"
check_symlink "$HOME/.config/wezterm/wezterm.lua" "~/.config/wezterm/wezterm.lua"
check_symlink "$HOME/.config/aerospace/aerospace.toml" "~/.config/aerospace/aerospace.toml"

echo ""
echo "Checking installed applications..."
check_command "stow" "GNU Stow"
check_command "starship" "Starship"
check_command "tmux" "Tmux"
check_command "aerospace" "Aerospace"
check_command "wezterm" "WezTerm"

echo ""
echo "Checking Zsh plugins..."
check_directory "$HOME/.zsh/zsh-autosuggestions" "zsh-autosuggestions"
check_directory "$HOME/.zsh/zsh-syntax-highlighting" "zsh-syntax-highlighting"
check_directory "$HOME/.zsh/zsh-completions" "zsh-completions"

echo ""
echo "Checking Tmux plugins..."
check_directory "$HOME/.tmux/plugins/tpm" "Tmux Plugin Manager"

echo ""
echo "=========================================="
echo "Verification complete!"
echo "=========================================="

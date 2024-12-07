#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# Log helper functions
log_info() {
    echo -e "${BLUE}INFO: ${NC}$1"
}

log_success() {
    echo -e "${GREEN}SUCCESS: ${NC}$1"
}

log_error() {
    echo -e "${RED}ERROR: ${NC}$1"
    exit 1
}

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    log_error "Dotfiles directory not found at $DOTFILES_DIR"
fi

# Install stow
log_info "Installing stow..."
sudo pacman -S stow

# Install dotfiles
log_info "Installing dotfiles..."
cd "$DOTFILES_DIR"
stow .

# Install additional packages
log_info "Installing additional packages..."
sudo pacman -S --needed base-devel git zsh zoxide fzf

# Ask User to install Hyprland
read -p "Do you want to install Hyprland? (Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    log_info "Skipping Hyprland installation"
    exit 0
fi

# Install Hyprland
log_info "Installing Hyprland..."
sudo pacman -S --needed hyprland

# Install Hyprland dependencies
log_info "Installing Hyprland dependencies..."
sudo pacman -S --needed waybar rofi

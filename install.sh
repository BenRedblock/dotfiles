#!/bin/bash

# Exit on error
set -e


source ./sources/utils.sh


if [ ! -f "sources/packages.conf" ]; then
    log_error "sources/packages.conf not found"
fi

source ./sources/packages.conf

log_info "Starting system setup..."

log_info "Checking for chaotic-aur repository..."
# Add chaotic-aur repository if not already installed
if grep -q chaotic-aur /etc/pacman.conf; then
    log_info "chaotic-aur repository is already installed."
else
    exit 1
    log_info "Adding chaotic-aur repository..."
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
    sudo bash -c 'echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf'

    log_success "Added chaotic-aur repository."
fi

# Update system packages
log_info "Updating system packages..."
sudo pacman -Syu --noconfirm

log_success "System packages updated successfully."

log_info "Installing yay..."
sudo pacman -S yay --noconfirm

log_info "Installing system utilities..."
install_packages "${SYSTEMUTILS[@]}"

log_info "Installing development tools..."
install_packages "${DEV_TOOLS[@]}"

log_info "Installing system maintenance tools..."
install_packages "${MAINTENANCE[@]}"

log_info "Installing media packages..."
install_packages "${MEDIA[@]}"


read -p "Do you want to install dotfiles? [y/N]: " choice
if [[ $choice == "y" ]]; then
    ./install-dotfiles.sh
fi

read -p "Do you want to benchmark and add the best mirrors? [Y/n]: " choice
if [[ $choice != "n" ]]; then
    rate-mirrors arch
fi

log_success "Mirrors benchmarked and added successfully."

log_success "System setup completed successfully!"

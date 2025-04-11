#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# Function to check if a package is installed
is_package_installed() {
    pacman -Qi "$1" &> /dev/null
}


is_group_installed() {
    pacman -Qg "$1" &> /dev/null
}

install_packages() {
    local packages=("$@")
    local to_install=()

    for pkg in "${packages[@]}"; do
        if ! is_package_installed "$pkg" && ! is_group_installed "$pkg"; then
            to_install+=("$pkg")
        fi
    done

    if [ ${#to_install[@]} -gt 0 ]; then
        echo "Installing: ${to_install[*]}"
        yay -S --noconfirm "${to_install[@]}"
    fi
}

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

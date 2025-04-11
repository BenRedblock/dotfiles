source ./sources/utils.sh

is_stow_installed() {
    pacman -Qi "stow" &> /dev/null
}

ORIGINAL_DIR=$(pwd)

log_info "Adding dotfiles..."

if ! is_stow_installed; then
    log_error "Stow is not installed. Please install it first."
fi


stow .

log_success "Dotfiles added successfully."

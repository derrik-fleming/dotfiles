#!/bin/bash

# Bootstrap script for chezmoi setup
# This script installs the prerequisites needed for chezmoi apply to succeed

set -euo pipefail

log_info() {
    echo "[INFO] $1" >&2
}

log_warning() {
    echo "[WARNING] $1" >&2
}

log_error() {
    echo "[ERROR] $1" >&2
}

check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        log_error "This script is designed for macOS only"
        exit 1
    fi
}

install_homebrew() {
    if command -v brew >/dev/null 2>&1; then
        log_info "Homebrew is already installed"
        return 0
    fi
    
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add brew to PATH for this session
    if [[ "$(uname -m)" == "arm64" ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
    else
        export PATH="/usr/local/bin:$PATH"
    fi
    
    if command -v brew >/dev/null 2>&1; then
        log_info "Homebrew installed successfully"
    else
        log_error "Homebrew installation failed"
        exit 1
    fi
}

install_chezmoi() {
    if command -v chezmoi >/dev/null 2>&1; then
        log_info "chezmoi is already installed"
        return 0
    fi
    
    log_info "Installing chezmoi..."
    if brew install chezmoi; then
        log_info "chezmoi installed successfully"
    else
        log_error "chezmoi installation failed"
        exit 1
    fi
}

install_1password_cli() {
    if command -v op >/dev/null 2>&1; then
        log_info "1Password CLI is already installed"
        return 0
    fi
    
    log_info "Installing 1Password CLI..."
    if brew install --cask 1password-cli; then
        log_info "1Password CLI installed successfully"
        log_info "You may need to authenticate with 'op signin' before using chezmoi"
    else
        log_error "1Password CLI installation failed"
        exit 1
    fi
}

main() {
    log_info "Starting chezmoi prerequisites installation..."
    
    check_macos
    install_homebrew
    install_chezmoi
    install_1password_cli
    
    log_info "All prerequisites installed successfully!"
    log_info "You can now run: chezmoi init --apply https://github.com/yourusername/dotfiles.git"
    log_info "Note: You may need to authenticate with 1Password CLI first: op signin"
}

main "$@"
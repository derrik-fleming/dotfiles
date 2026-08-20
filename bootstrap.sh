#!/usr/bin/env bash
# Install the minimum prerequisites for chezmoi on macOS or Linux.
set -euo pipefail

log() { printf '[%s] %s\n' "$1" "$2" >&2; }

install_homebrew() {
  if [[ "$(uname -s)" != Darwin ]]; then
    log ERROR 'Homebrew bootstrap is macOS-only; Linux hosts use their native package manager.'
    exit 1
  fi
  if command -v brew >/dev/null 2>&1; then
    return
  fi
  log INFO 'Installing Homebrew...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_chezmoi() {
  if command -v chezmoi >/dev/null 2>&1; then
    log INFO "chezmoi is already installed ($(chezmoi --version | head -1))"
    return
  fi

  case "$(uname -s)" in
    Darwin)
      install_homebrew
      brew install chezmoi
      ;;
    Linux)
      mkdir -p "$HOME/.local/bin"
      sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
      export PATH="$HOME/.local/bin:$PATH"
      ;;
    *)
      log ERROR "Unsupported operating system: $(uname -s)"
      exit 1
      ;;
  esac
}

install_1password_cli() {
  command -v op >/dev/null 2>&1 && return
  [[ "$(uname -s)" == Darwin ]] || {
    log ERROR 'Automatic 1Password CLI installation is supported only on macOS.'
    exit 1
  }
  install_homebrew
  brew install --cask 1password-cli
}

with_1password=false
if [[ "${1:-}" == "--with-1password" ]]; then
  with_1password=true
elif [[ $# -ne 0 ]]; then
  log ERROR "Unknown option: $1"
  exit 2
fi

install_chezmoi
$with_1password && install_1password_cli
log INFO 'Prerequisites are ready. Initialize with: chezmoi init --apply git@github.com:derrik-fleming/dotfiles.git'
log INFO 'Trusted macOS workstation only: rerun bootstrap.sh --with-1password to install the 1Password CLI.'

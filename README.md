# Dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io) for cross-platform development environments.

## Features

- **Cross-platform**: Works on macOS (Intel/Apple Silicon), Arch Linux, and Debian
- **Platform-aware templates**: Darwin-only scripts and settings are excluded on Linux
- **Machine-local identity data**: Git identity and signing-key paths live in chezmoi data
- **Portable shell startup**: optional tools and Homebrew are discovered at runtime
- **Modern shell setup**: zsh with starship, atuin, and productivity tools

## Quick Start

### Prerequisites

Install chezmoi:

```bash
# macOS
brew install chezmoi

# Linux
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
```

### Initial Setup

```bash
# Initialize dotfiles (replace with your repo URL)
chezmoi init --apply https://github.com/yourusername/dotfiles.git

# Or for SSH
chezmoi init --apply git@github.com:yourusername/dotfiles.git
```

### Configuration

Edit `~/.config/chezmoi/chezmoi.toml` to customize:

```toml
[data]
    # Set these per machine; do not put an identity or key in the repository.
    name = "Your Name"
    email = "you@example.com"
    context = "work" # or "personal"
    # workstation enables 1Password-backed configuration; server does not.
    profile = "workstation"
    # Optional path used for GitHub SSH commit signing.
    githubSigningKey = "~/.ssh/id_ed25519.pub"
```

### Trusted Workstations and Remote Hosts

`profile` is a security boundary, not just a convenience setting:

- Use `profile = "workstation"` only on a trusted, interactive Mac or Linux desktop. It enables 1Password-backed configuration and the local Kagi MCP wrapper.
- Use `profile = "server"` on EC2, VPS, CI, containers, and other remote hosts. This is the Linux default. It excludes 1Password configuration and Kagi, and does not require `op` or a vault session.
- macOS defaults to `workstation`; set the profile explicitly on trusted Linux desktops.

For a trusted macOS workstation, install the 1Password CLI explicitly:

```bash
./bootstrap.sh --with-1password
```

For an EC2 or other remote host, use the regular bootstrap and set the profile before applying:

```toml
# ~/.config/chezmoi/chezmoi.toml
[data]
profile = "server"
```

The managed SSH configuration sets `ForwardAgent no`, so a local 1Password SSH
agent is used to connect *to* a remote host but is never exposed *on* it. If a
server needs its own credentials, use a separate deploy key, cloud identity, or
a server-side secret manager—not your personal 1Password vault.

When adding a template that reads an `op://` secret, guard it with the
`workstation` profile and exclude any generated secret-backed command on server
profiles.

## Managed Files

### Cross-Platform Configs
- **Shell**: `.zshrc` with brew path detection
- **Git**: Work/personal email templates
- **SSH**: Platform-aware keychain settings
- **Terminal**: starship, ghostty configurations
- **Editor**: Complete Neovim setup with plugins
- **Tools**: atuin (shell history), lazygit, gh (GitHub CLI)

### Platform-Specific
- **macOS**: AeroSpace window manager and Homebrew bundle (Darwin-only)
- **Arch Linux**: native `pacman` package bootstrap; Homebrew is never installed
- **Debian**: native `apt` package bootstrap; Homebrew is never installed

### Package Inventory

Homebrew package lists are data-driven, following the same pattern as the example
repository:

- `.chezmoidata/common.toml` contains command-line tools shared with future platform installers.
- `.chezmoidata/darwin.toml` contains macOS taps, formulae, casks, fonts, and App Store apps.
- `.chezmoidata/arch.toml` contains Arch-specific pacman and optional AUR packages.
- `.chezmoidata/debian.toml` contains Debian apt packages and packages that need an upstream source.
- `private_dot_config/homebrew/Brewfile.tmpl` only sorts, de-duplicates, and renders Homebrew data.

Edit the data files, then preview the generated bundle with:

```bash
chezmoi execute-template < ~/.local/share/chezmoi/private_dot_config/homebrew/Brewfile.tmpl
```

## Usage

### Daily Operations

```bash
# Check what would change
chezmoi status

# Apply changes
chezmoi apply

# Edit a config file
chezmoi edit ~/.zshrc

# Add new config file
chezmoi add ~/.config/newapp/config.yml
```

### Updating

```bash
# Pull latest changes
chezmoi update

# Or manually
cd ~/.local/share/chezmoi
git pull
chezmoi apply
```

### Work vs Personal Machine

Set the machine's Git identity by editing `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    name = "Your Name"
    email = "you@company.com"
    context = "work"
```

Then apply changes:

```bash
chezmoi apply
```

## Adding New Configs

### Simple Files
```bash
chezmoi add ~/.config/app/config.yml
```

### Platform-Specific Files
```bash
chezmoi add --template ~/.config/macos-only-app/config
```

Then edit the template to add conditionals:
```go
{{- if eq .chezmoi.os "darwin" -}}
# macOS-specific config
{{- end -}}
```

### Templates with Secrets

For configs with sensitive data, use 1Password integration:

```bash
chezmoi add --template ~/.config/app/config.yml
```

Edit the template:
```go
api_key = "{{ onepassword "item-uuid" "api-key" }}"
```

## Troubleshooting

### Template Errors
```bash
# Check template syntax
chezmoi execute-template < ~/.local/share/chezmoi/file.tmpl

# Debug template variables
chezmoi data
```

### Path Issues
Check that tools are installed and paths are correct:
```bash
# Verify brew prefix
echo $HOMEBREW_PREFIX

# Check tool locations
which starship atuin
```

### Permission Issues
```bash
# Fix SSH permissions
chmod 600 ~/.ssh/config
chmod 700 ~/.ssh
```

## Dependencies

### Required Tools
- **Shell**: zsh (default on macOS 10.15+)
- **Package Manager**: Homebrew (macOS/Linux)
- **Git**: For version control
- **Neovim**: Text editor

### Optional Tools
- **1Password CLI**: Secret management
- **Starship**: Shell prompt
- **Atuin**: Shell history sync
- **AeroSpace**: macOS window manager
- **Ghostty**: Terminal emulator

### Installation Script

```bash
#!/bin/bash
# Install common tools via Homebrew

# Core tools
brew install git neovim starship atuin

# Terminal tools
brew install bat lsd zoxide fzf direnv

# Development tools
brew install gh lazygit

# macOS-specific
if [[ "$(uname)" == "Darwin" ]]; then
    brew install --cask aerospace ghostty
fi
```

## Contributing

1. Make changes to configs in `~/.local/share/chezmoi/`
2. Test with `chezmoi apply --dry-run`
3. Commit and push changes
4. Test on different platforms

## License

Personal dotfiles - use at your own discretion.
# Dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io) for cross-platform development environments.

## Features

- **Cross-platform**: Works on macOS (Intel/Apple Silicon) and Linux
- **Platform-aware templates**: Conditional configs for Darwin-specific tools
- **Work/Personal separation**: Template-based git configuration
- **Secret management**: 1Password integration for sensitive data
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
    name = "your-name"
    work_email = "you@company.com"
    personal_email = "you@gmail.com"
    email_type = "work"  # or "personal"

[onepassword]
    prompt = false
```

## Managed Files

### Cross-Platform Configs
- **Shell**: `.zshrc` with brew path detection
- **Git**: Work/personal email templates
- **SSH**: Platform-aware keychain settings
- **Terminal**: starship, ghostty configurations
- **Editor**: Complete Neovim setup with plugins
- **Tools**: atuin (shell history), lazygit, gh (GitHub CLI)

### Platform-Specific
- **macOS**: AeroSpace window manager (Darwin-only)
- **Linux**: (Conditional configs as needed)

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

Switch git configuration by editing `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    email_type = "work"    # or "personal"
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
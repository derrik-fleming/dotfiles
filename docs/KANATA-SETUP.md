# Kanata Keyboard Remapping Setup

Complete guide for setting up Kanata with chezmoi on macOS.

## Overview

Kanata provides advanced keyboard remapping with Colemak-DH layout and home row modifiers. This setup requires Karabiner Elements as a dependency and careful configuration.

## Prerequisites

1. **Karabiner Elements** (full version, not just VirtualHID Driver)
2. **Kanata** via Homebrew
3. **Admin privileges** for system service installation

## Step-by-Step Setup

### 1. Install Dependencies

```bash
# Install via Brewfile (managed by chezmoi)
brew bundle --file=~/Brewfile

# Or manually:
brew install kanata
```

Download and install **Karabiner Elements** from: https://karabiner-elements.pqrs.org/

### 2. Configure Karabiner Elements

⚠️ **IMPORTANT**: Install the FULL Karabiner Elements, not just the VirtualHID Driver

Follow ALL Karabiner prompts to enable in **System Settings**:

#### Login Items & Extensions
- ✅ **Karabiner-Elements Non-Privileged Agents** (enable)
- ✅ **Karabiner-Elements Privileged Daemons** (enable)
- ✅ **Driver Extensions > .Karabiner-VirtualHIDDevice-Manager** (enable)

#### Privacy & Security > Input Monitoring
Enable for:
- ✅ **karabiner_grabber**
- ✅ **Karabiner-Elements**
- ✅ **Karabiner-EventViewer**  
- ✅ **Terminal** (or your terminal app)
- ✅ **kanata** (will be added automatically)

### 3. QUIT Karabiner Completely

🚨 **CRITICAL STEP**: Before running Kanata, you MUST quit ALL Karabiner processes:

1. Quit the Karabiner-Elements app
2. Quit Karabiner from the menu bar (top of screen)
3. Verify no processes are running:
   ```bash
   pgrep -f "Karabiner|karabiner"  # Should return nothing
   ```

If processes are still running:
```bash
killall Karabiner-Elements karabiner_grabber karabiner_observer
```

### 4. Apply Chezmoi Configuration

```bash
# This will install Kanata config and run the service setup script
chezmoi apply
```

The setup script will:
- ✅ Check prerequisites
- ✅ Verify Karabiner is properly quit
- ✅ Test Kanata manually first
- ✅ Install and start the system service
- ✅ Verify everything is working

### 5. Reboot (Recommended)

Reboot your Mac to ensure all changes take effect properly.

## Manual Testing

Test Kanata manually before the service setup:

```bash
# Test configuration (dry run)
kanata --cfg ~/.config/kanata/config.kbd --dry-run

# Test actual functionality (run for a few seconds)
sudo kanata --cfg ~/.config/kanata/config.kbd
```

## Service Management

Once installed via chezmoi, manage the service with:

```bash
# Check status
sudo launchctl list | grep kanata

# View logs
tail -f /var/log/kanata.log
tail -f /var/log/kanata.error.log

# Manual control (if needed)
sudo launchctl stop com.derrik.fleming.kanata
sudo launchctl start com.derrik.fleming.kanata
```

## Keyboard Layout

The included config provides:

- **Colemak-DH** layout as default
- **Home row modifiers**: A(Ctrl), R(Alt), S(Cmd), T(Shift) | N(Shift), E(Cmd), I(Alt), O(Ctrl)
- **Hyper key** on Escape
- **Layer switching** with grave key
- **QWERTY toggle** available

## Troubleshooting

### Common Issues

1. **"Device in use" error**
   - Karabiner processes are still running
   - Solution: Quit all Karabiner processes completely

2. **Permission denied**
   - Input Monitoring not enabled for kanata
   - Solution: Add kanata to Input Monitoring permissions

3. **Service won't start**
   - Check logs: `tail -f /var/log/kanata.error.log`
   - Verify config: `kanata --cfg ~/.config/kanata/config.kbd --dry-run`

4. **Config validation errors**
   - Check syntax in `~/.config/kanata/config.kbd`
   - Refer to [Kanata documentation](https://github.com/jtroo/kanata)

### Debug Commands

```bash
# Check if Karabiner processes are running
pgrep -f "Karabiner|karabiner"

# Test config syntax
kanata --cfg ~/.config/kanata/config.kbd --dry-run

# Check service status
sudo launchctl list | grep derrik.fleming

# View system logs
log show --predicate 'process == "kanata"' --last 5m
```

### Starting Fresh

If you need to start over:

```bash
# Stop and remove service
sudo launchctl stop com.derrik.fleming.kanata
sudo launchctl unload /Library/LaunchDaemons/com.derrik.fleming.kanata.plist
sudo rm /Library/LaunchDaemons/com.derrik.fleming.kanata.plist

# Remove chezmoi marker (to re-run setup script)
rm ~/.local/share/chezmoi/.chezmoi.run_once_after_setup-kanata-service.sh

# Re-apply chezmoi
chezmoi apply
```

## Security Notes

- Kanata runs as root with low-level keyboard access
- Only install if you understand the security implications  
- Keep config files secure and version controlled
- Regularly review and update configurations

## References

- [Kanata GitHub](https://github.com/jtroo/kanata)
- [Karabiner Elements](https://karabiner-elements.pqrs.org/)
- [Colemak-DH Layout](https://colemakmods.github.io/mod-dh/)
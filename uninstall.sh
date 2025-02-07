#!/bin/bash

set -e  # Stop the script in case of an error

THEME_NAME="Cachy"
THEME_DIR="/boot/grub/themes/$THEME_NAME"
GRUB_CONFIG="/etc/default/grub"
GRUB_CMD="grub-mkconfig"

# Check if the user has root permissions
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Remove the theme directory
if [[ -d "$THEME_DIR" ]]; then
    rm -rf "$THEME_DIR"
    echo "Theme '$THEME_NAME' removed."
else
    echo "Theme '$THEME_NAME' is not installed."
fi

# Remove the theme entry from GRUB configuration
if grep -q "^GRUB_THEME=" "$GRUB_CONFIG"; then
    sed -i "/^GRUB_THEME=/d" "$GRUB_CONFIG"
    echo "GRUB theme setting removed from configuration."
fi

# Update GRUB according to the distribution
if command -v grub-mkconfig &> /dev/null; then
    $GRUB_CMD -o /boot/grub/grub.cfg
elif command -v update-grub &> /dev/null; then
    update-grub
else
    echo "Could not update GRUB automatically. Please update manually."
    exit 1
fi

echo "Uninstallation of theme '$THEME_NAME' completed successfully!"

#!/bin/bash

set -e  # Stop the script in case of an error

THEME_NAME="Cachy"
THEME_ARCHIVE="Cachy.tar"
THEME_DIR="/boot/grub/themes/$THEME_NAME"
GRUB_CONFIG="/etc/default/grub"
GRUB_CMD="grub-mkconfig"

# Check if the user has root permissions
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Create the GRUB themes directory if it does not exist
mkdir -p /boot/grub/themes

# Remove any previous installation of the theme
rm -rf "$THEME_DIR"

# Extract the theme
mkdir "$THEME_DIR"
tar -xf "$THEME_ARCHIVE" -C "$THEME_DIR"

# Add the theme to the GRUB configuration file
if grep -q "^GRUB_THEME=" "$GRUB_CONFIG"; then
    sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"$THEME_DIR/theme.txt\"|" "$GRUB_CONFIG"
else
    echo "GRUB_THEME=\"$THEME_DIR/theme.txt\"" >> "$GRUB_CONFIG"
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

echo "Theme '$THEME_NAME' installed successfully!"

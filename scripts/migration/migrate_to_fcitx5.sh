#!/bin/bash
# IBus+Mozc環境からfcitx5+Mozcへの移行
# Ubuntu 24.04のIBus二重入力バグの回避策

echo "=== Migrating from IBus to fcitx5-mozc ==="

# Install fcitx5 packages
sudo apt install -y im-config fcitx5 fcitx5-mozc fcitx5-config-qt fcitx5-frontend-all

# Set fcitx5 as default input method
im-config -n fcitx5

# Remove ibus-mozc (keep ibus itself as GNOME dependency)
sudo apt remove -y ibus-mozc

echo ""
echo "Migration complete. Please reboot your system."
echo "After reboot:"
echo "  1. Run 'fcitx5-diagnose' to verify the setup"
echo "  2. Open 'Fcitx5 Configuration' from application menu"
echo "  3. Verify 'Mozc' is in the input method list"

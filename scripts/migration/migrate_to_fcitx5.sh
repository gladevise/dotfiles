#!/bin/bash
set -euo pipefail

# IBus+Mozc環境からfcitx5+Mozcへの移行
# Ubuntu 24.04のIBus二重入力バグの回避策

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Migrating from IBus to fcitx5-mozc ==="

# Install fcitx5 packages
sudo apt install -y im-config fcitx5 fcitx5-mozc fcitx5-config-qt fcitx5-frontend-all

# Install Japanese language support
sudo apt install -y language-pack-ja language-pack-ja-base \
  language-pack-gnome-ja language-pack-gnome-ja-base fonts-noto-cjk

# Generate Japanese locale
if ! locale -a 2>/dev/null | grep -q 'ja_JP\.utf8'; then
  echo "Generating ja_JP.UTF-8 locale..."
  sudo locale-gen ja_JP.UTF-8
fi

# Set fcitx5 as default input method
im-config -n fcitx5

# Remove ibus-mozc (keep ibus itself as GNOME dependency)
if dpkg -l ibus-mozc 2>/dev/null | grep -q '^ii'; then
  sudo apt remove -y ibus-mozc
else
  echo "ibus-mozc is not installed, skipping removal."
fi

# Deploy fcitx5 configuration files via link.sh
echo "Deploying fcitx5 configuration files..."
bash "$SCRIPT_DIR/../link.sh"

echo ""
echo "Migration complete. Please reboot your system."
echo "After reboot, run 'fcitx5-diagnose' to verify the setup."

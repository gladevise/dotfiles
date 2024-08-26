
#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# Install OBS Studio
# https://flathub.org/apps/com.obsproject.Studio
flatpak install -y flathub com.obsproject.Studio

# Install CopyQ
# https://flathub.org/apps/com.github.hluk.copyq
flatpak install -y flathub com.github.hluk.copyq

# Install wezterm
# https://flathub.org/apps/org.wezfurlong.wezterm
flatpak install flathub org.wezfurlong.wezterm

popd
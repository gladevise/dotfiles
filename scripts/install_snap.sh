#!/bin/bash
pushd $PWD
cd `dirname $0`
echo $PWD

# declare -a packages

# packages=(
# )

# sudo snap install ${packages[@]}

sudo snap install blender --classic

popd
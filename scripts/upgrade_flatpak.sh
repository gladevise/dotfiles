#!/bin/bash

pushd $PWD
cd `dirname $0`

flatpak update -y

popd
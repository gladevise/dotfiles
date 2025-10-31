#!/bin/bash

pushd $PWD
cd `dirname $0`

systemctl --user enable --now podman.socket
systemctl --user status podman.socket --no-pager

popd
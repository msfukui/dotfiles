#!/bin/bash

# FLUTTER_VERSION:
#   visit "https://docs.flutter.dev/get-started/install/linux"
#   See "Install Flutter manually", version number
FLUTTER_VERSION=3.10.3

FLUTTER_DOWNLOAD_FILE="flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
FLUTTER_DOWNLOAD_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

if [ ! -d "${HOME}/dev" ]; then
  mkdir -p ${HOME}/dev
fi

if [ ! -d "${HOME}/dev/flutter" ]; then
  pushd ${HOME}/dev
  curl -o flutter_linux_${FLUTTER_VERSION}-stable.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
  tar -xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
  rm -f flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
  export PATH="$PATH:`pwd`/flutter/bin"
  flutter precache
  popd
fi

flutter doctor -v

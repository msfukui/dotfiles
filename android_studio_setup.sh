#!/bin/bash

# ANDROID_STUDIO_DOWNLOAD_URL:
#   visit "https://developer.android.com/studio/index.html#downloads"
#   -> Download "Command line tools"
ANDROID_STUDIO_DOWNLOAD_URL="$1"

if [ "${ANDROID_STUDIO_DOWNLOAD_URL}" = "" ]; then
  echo "ERROR: ANDROID_STUDIO_DOWNLOAD_URL is empty."
  echo "usage: $0 [ANDROID_STUDIO_DOWNLOAD_URL]"
  exit 1
fi

if [ ! -d "${HOME}/Android/SDK/cmdline-tools" ]; then
  mkdir -p ${HOME}/Android/SDK/cmdline-tools
fi

if [ ! -d "${HOME}/Android/SDK/cmdline-tools/latest/bin" ]; then
  curl -o commandlinetools-linux-latest.zip ${ANDROID_STUDIO_DOWNLOAD_URL}
  unzip commandlinetools-linux-latest.zip
  rm -f commandlinetools-linux-latest.zip
  mv cmdline-tools ${HOME}/Android/SDK/cmdline-tools/latest
  export ANDROID_HOME=$HOME/Android/SDK
  export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
fi

sdkmanager --update

#!/usr/bin/env bash

echo "Installing c++ toolchain"

sudo apt-get update >/dev/null 2>&1
sudo apt-get install -y build-essential gcc cmake libglu1-mesa-dev libogg-dev libopenal-dev libgtk2.0-dev curl lib32z1-dev
#!/usr/bin/env bash

echo "Installing android toolchain"

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y build-essential gcc cmake libglu1-mesa-dev libogg-dev libopenal-dev libgtk2.0-dev libncurses5:i386 libstdc++6:i386 zlib1g:i386 curl lib32z1-dev
sudo apt-get install -y ia32-libs
sudo apt-get install -y libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1
sudo apt-get install -y python-software-properties

mkdir -p /opt/android
rm -rf /opt/android
mkdir -p /opt/android

echo "Installing Android SDK..."
cd ~
wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz >/dev/null 2>&1
tar -zxvf android-sdk_r24.4.1-linux.tgz
mv ~/android-sdk-linux /opt/android
rm -rf ~/android-sdk-linux
rm -rf ~/android-sdk_r24.4.1-linux.tgz

echo "Installing Android NDK..."
cd ~
wget http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin >/dev/null 2>&1
chmod a+x android-ndk-r10e-linux-x86_64.bin
./android-ndk-r10e-linux-x86_64.bin
mv ~/android-ndk-r10e /opt/android
rm -rf ~/android-ndk-r10e
rm -rf ~/android-ndk-r10e-linux-x86_64.bin

chown -R vagrant:vagrant /opt/android

su - vagrant

echo "Updating ANDROID_HOME..."
cd ~
echo "export ANDROID_HOME=\"/opt/android/android-sdk-linux\"" >> .profile
echo "export ANDROID_NDK=\"/opt/android/android-ndk-r10e\"" >> .profile
echo "export PATH=\$ANDROID_NDK:\$ANDROID_HOME/tools:\$ANDROID_HOME/platform-tools:\$PATH" >> .profile

source ~/.profile

echo "yes" | android update sdk -u -a -t 33

sudo mkdir -p /opt/android-toolchain-arm
sudo chown -R vagrant:vagrant /opt/android-toolchain-arm
/opt/android/android-ndk-r10e/build/tools/make-standalone-toolchain.sh --platform=android-16 --arch=arm --install-dir=/opt/android-toolchain-arm

sudo mkdir -p /opt/android-toolchain-x86
sudo chown -R vagrant:vagrant /opt/android-toolchain-x86
/opt/android/android-ndk-r10e/build/tools/make-standalone-toolchain.sh --platform=android-16 --arch=x86 --install-dir=/opt/android-toolchain-x86

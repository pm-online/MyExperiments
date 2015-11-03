# Program : Ionic Installation Script For Linux
# Author : Pankaj Kumar Mishra
# Created On : Oct 30, 2015
# Copyright (C) 2015

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#!/bin/bash

# source directory
SRC=$(cd ~/ && pwd)

# destination directory
DEST=/opt

# location where the android sdk will be installed
ANDROID_SDK_DEST=/opt/android-sdk

# location where the node will be installed
NODE_DEST=/opt/node

# identify the architecture i.e. x86  or x64
ARCH="$(lscpu | grep 'Architecture' | awk -F\: '{ print $2 }' | tr -d ' ')"

# Latest Android Linux SDK for x64 and x86 as of 30-10-2015
ANDROID_SDK_X64="http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz"
ANDROID_SDK_X86="http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz"

# NodeJS for x64 and x86
NODE_X64="http://nodejs.org/dist/v0.12.2/node-v0.12.2-linux-x64.tar.gz"
NODE_X86="http://nodejs.org/dist/v0.12.2/node-v0.12.2-linux-x86.tar.gz"


if [ "$ARCH" == "x86_64" ]; then
    dpkg --add-architecture i386
fi

# Update the software repository lists
apt-get update

cd ~/Desktop

if [ "$ARCH" == "x86_64" ]; then

    wget "$NODE_X64" -O "nodejs.tgz"
    wget "$ANDROID_SDK_X64" -O "android-sdk.tgz"

    tar zxf "nodejs.tgz" -C "$DEST"
    tar zxf "android-sdk.tgz" -C "$DEST"

    cd "$DEST" && mv "android-sdk-linux" "android-sdk"
    cd "$DEST" && mv "node-v0.12.2-linux-x64" "node"

    # Android SDK requires some x86 architecture libraries even on x64 system
    apt-get install -qq -y libc6:i386 libgcc1:i386 libstdc++6:i386 libz1:i386

else

    wget "$NODE_X86" -O "nodejs.tgz"
    wget "$ANDROID_SDK_X86" -O "android-sdk.tgz"

    tar zxf "nodejs.tgz" -C "$DEST"
    tar zxf "android-sdk.tgz" -C "$DEST"

    cd "$DEST" && mv "android-sdk-linux" "android-sdk"
    cd "$DEST" && mv "node-v0.12.2-linux-x86" "node"

fi

cd "$DEST" && chown root:root "android-sdk" -R
cd "$DEST" && chmod 777 "android-sdk" -R

cd ~/

# Add Android and NPM paths to the profile to preserve settings on boot
echo "export PATH=\$PATH:$ANDROID_SDK_PATH/tools" >> ".profile"
echo "export PATH=\$PATH:$ANDROID_SDK_PATH/platform-tools" >> ".profile"
echo "export PATH=\$PATH:$NODE_PATH/bin" >> ".profile"

# Add Android and NPM paths to the temporary user path to complete installation
export PATH=$PATH:$ANDROID_SDK_PATH/tools
export PATH=$PATH:$ANDROID_SDK_PATH/platform-tools
export PATH=$PATH:$NODE_PATH/bin

# Install JDK and Apache Ant
apt-get -qq -y install default-jdk ant

# Set JAVA_HOME based on the default OpenJDK installed
export JAVA_HOME="$(find /usr -type l -name 'default-java')"
if [ "$JAVA_HOME" != "" ]; then
    echo "export JAVA_HOME=$JAVA_HOME" >> ".profile"
fi

# Install Apache Cordova and Ionic Framework
npm install -g cordova
npm install -g ionic

cd "$DEST" && chmod 777 "node" -R

# Clean up any files that were downloaded from the internet
cd ~/Desktop && rm "android-sdk.tgz"
cd ~/Desktop && rm "nodejs.tgz"

echo "--------------------------------------------------"
echo "Restart the system to complete the installation..."

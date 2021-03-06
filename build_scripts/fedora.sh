#!/bin/bash


WORKDIR=$(pwd)/opentrack_workspace
DEPS="qt5-qtbase-devel qt5-qtbase-private-devel qt5-qttools-devel qt5-qtserialport-devel procps-ng-devel procps-ng opencv-devel opencv libevdev-devel libevdev make cmake unzip gcc g++ glibc-devel glibc-devel.i686 libstdc++-devel libstdc++-devel.i686 wine wine-devel wine-devel.i686"

sudo dnf upgrade -y
sudo dnf install -y $DEPS

mkdir -p $WORKDIR
cd $WORKDIR

wget -O source.zip $(curl -s https://api.github.com/repos/opentrack/opentrack/releases/latest | grep zipball_url | cut -d '"' -f 4)
unzip source.zip
mv $(ls | grep opentrack) source

mkdir -p build
sleep 1
cd build
cmake ../source -DSDK_WINE:BOOL=ON -DCMAKE_INSTALL_PREFIX:PATH=/home/$USER/.local
make install -j$(nproc)

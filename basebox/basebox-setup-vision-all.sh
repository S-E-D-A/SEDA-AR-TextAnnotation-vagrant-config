#!/usr/bin/env bash

set -ex

apt-get -y update 
apt-get -y upgrade > /dev/null

# PTI is Package To Install

# Tools
PTI="${PTI} build-essential"
PTI="${PTI} g++"
PTI="${PTI} gcc"
PTI="${PTI} cmake"
PTI="${PTI} vim"
PTI="${PTI} ddd"
PTI="${PTI} gdb"
PTI="${PTI} valgrind"
PTI="${PTI} git"
PTI="${PTI} gitk"
PTI="${PTI} pkg-config"

# Libs
PTI="${PTI} libx11-6"
PTI="${PTI} libx11-dev"

PTI="${PTI} freeglut3"
PTI="${PTI} freeglut3-dev"

PTI="${PTI} x264"
PTI="${PTI} libv4l-dev"
PTI="${PTI} libavcodec-dev"
PTI="${PTI} libavformat-dev"
PTI="${PTI} libswscale-dev"
PTI="${PTI} libxine-dev"
PTI="${PTI} libgstreamer-plugins-base0.10-dev"
PTI="${PTI} libgstreamer0.10-dev"
PTI="${PTI} ffmpeg"

PTI="${PTI} libtiff4"
PTI="${PTI} libtiff4-dev"

PTI="${PTI} libjpeg8"
PTI="${PTI} libjpeg-turbo8"
PTI="${PTI} libjpeg8-dev"
PTI="${PTI} libjpeg-turbo8-dev"

PTI="${PTI} libpng3-dev"
PTI="${PTI} libpng12-dev"
PTI="${PTI} libpng++-dev"
PTI="${PTI} libpng12-0-dev"

PTI="${PTI} liblapack3gf"
PTI="${PTI} liblapack-dev"
PTI="${PTI} liblapack-doc"

PTI="${PTI} libblas3gf"
PTI="${PTI} libblas-dev"
PTI="${PTI} libblas-doc"

PTI="${PTI} libtbb-dev"
PTI="${PTI} libreadline-dev"

PTI="${PTI} libboost-all-dev"
PTI="${PTI} libopencv-dev"

# Install all PTI packages
apt-get install -y ${PTI}

# --TooN
if [ ! -f /.tooninstalled ]; then
  echo "Provisioning TooN."
  git clone git://github.com/edrosten/TooN.git
  cd TooN
  ./configure
  make
  sudo make install
  cd ../
  touch /.tooninstalled
  chown -R vagrant:vagrant TooN
else
  echo "TooN already installed."
fi

# --LibCVD
if [ ! -f /.libcvdinstalled ]; then
  echo "Provisioning libcvd."
  git clone git://github.com/edrosten/libcvd.git
  cd libcvd
  export CXXFLAGS=-D_REENTRANT
  ./configure --enable-gpl
  make -j4
  sudo make install
  cd ../
  touch /.libcvdinstalled
  chown -R vagrant:vagrant libcvd
else
  echo "LibCVD already installed."
fi

# --GVars
if [ ! -f /.gvarsinstalled ]; then
    echo "Provisioning Gvars."
    git clone https://github.com/edrosten/gvars.git 
    cd gvars
    ./configure
    make
    sudo make install
    cd ../
    touch /.gvarsinstalled
    chown -R vagrant:vagrant gvars
else
    echo "GVars already installed."
fi

# Update ldconfig
sudo ldconfig
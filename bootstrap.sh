#!/usr/bin/env bash

# To display detailed information when executing this script
set -ex

# --UPDATE
apt-get -y update

# --BUILD TOOLS
apt-get -y install build-essential
apt-get -y install g++
apt-get -y install gcc
apt-get -y install cmake

# --TOOLS
apt-get -y install vim
apt-get -y install gdb
apt-get -y install gitk
apt-get -y install pkg-config

# --MULTI-THREADING
apt-get -y install libtbb-dev

# --GRAPHICS LIBRARIES
apt-get -y install freeglut3-dev
apt-get -y install libgtk2.0-dev
apt-get -y install libgtkglext1-dev

# --VIDEO LIBRARIES
apt-get -y install x264
apt-get -y install libv4l-dev
apt-get -y install libavcodec-dev
apt-get -y install libavformat-dev
apt-get -y install libswscale-dev
apt-get -y install libxine-dev
apt-get -y install libgstreamer-plugins-base0.10-dev
apt-get -y install libgstreamer0.10-dev
apt-get -y install ffmpeg

# --IMAGE LIBRARIES
apt-get -y install libtiff4-dev
apt-get -y install libjpeg-turbo8
apt-get -y install libjpeg8-dev
apt-get -y install libjpeg-turbo8-dev
apt-get -y install libpng12-0
apt-get -y install libpng12-dev
apt-get -y install libjasper-dev

# --LINEAR ALGEBRA for PTAM
apt-get -y install liblapack3gf
apt-get -y install liblapack-dev
apt-get -y install libblas3gf
apt-get -y install libblas-dev

# --ADD-ONS for PTAM
apt-get -y install libreadline-dev

# -- OpenCV-2.3
apt-get -y install libopencv-dev

# -- Change user to vagrant
su vagrant

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

# --SEDA-AR Project Repo
if [ ! -f /.projectrepocloned ]; then
	echo "Cloning SEDA-AR-TextAnnotation."
	git clone https://github.com/S-E-D-A/SEDA-AR-TextAnnotation.git
	touch /.projectrepoinstalled
	chown -R vagrant:vagrant SEDA-AR-TextAnnotation
else
	echo "SEDA-AR-TextAnnotation already cloned."
fi

# Add sync folder
mkdir -p "/vagrant/sync"
sudo chown -R vagrant:vagrant "/vagrant/sync/"

# Link sync directory into home
if [[ ! -L "/home/vagrant/sync" ]]; then
  ln -s "/vagrant/sync" "/home/vagrant/sync"
  chown -R vagrant:vagrant /home/vagrant/sync
fi

# Update ldconfig
sudo ldconfig

echo "Done! Vagrant provision complete."

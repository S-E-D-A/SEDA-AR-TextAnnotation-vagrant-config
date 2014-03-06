#!/usr/bin/env bash

# To display detailed information when executing this script
set -ex

# --UPDATE
apt-get -y update

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

echo "Done! Vagrant provision complete."

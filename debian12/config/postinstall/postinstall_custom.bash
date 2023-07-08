#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt --yes install git
git clone https://github.com/odem/mps.git /opt/mps
cd /opt/mps || exit 1

./all.bash -u mps -p mps
# ./bootstrap.bash -u mps -p mps
# ./terminal.bash -u mps
# ./desktop.bash -u mps

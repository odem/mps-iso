#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt --yes install git sudo vim make python3 python3-click


git clone https://github.com/odem/mps.git /opt/mps
cd /opt/mps || exit 1
./all.bash


#!/bin/bash
# Pull this file down, make it executable and run it with sudo
# chmod u+x ubuntu-build-yaws.sh
# sudo ./ubuntu-build-yaws.sh
if [ $(id -u) != "0" ]; then
echo "You must be the superuser to run this script" >&2
exit 1
fi

if [ -e yaws-1.99.tar.gz ]; then
echo "Good! 'yaws-1.99.tar.gz' already exists. Skipping download."
else
wget http://yaws.hyber.org/download/yaws-1.99.tar.gz
fi

tar -xvzf yaws-1.99.tar.gz

cd yaws

./configure
make
make install
exit 0 

#!/bin/bash
# Pull this file down, make it executable and run it with sudo
# chmod u+x ubuntu-build-erlang-and-yasw.sh
# sudo ./ubuntu-build-erlang-and-yasw.sh
 
if [ $(id -u) != "0" ]; then
echo "You must be the superuser to run this script" >&2
exit 1
fi
apt-get update
 
# Install the build tools (dpkg-dev g++ gcc libc6-dev make)
apt-get -y install build-essential
 
# automatic configure script builder (debianutils m4 perl)
apt-get -y install autoconf
 
# Needed for HiPE (native code) support, but already installed by autoconf
apt-get -y install m4
 
# Needed for terminal handling (libc-dev libncurses5 libtinfo-dev libtinfo5 ncurses-bin)
apt-get -y install libncurses5-dev

# Java SDK
apt-get -y install openjdk-7-jdk

# For building with wxWidgets
apt-get -y install libwxgtk2.8-dev libgl1-mesa-dev libglu1-mesa-dev libpng3
 
# For building ssl (libssh-4 libssl-dev zlib1g-dev)
apt-get -y install libssh-dev

# ODBC support (libltdl3-dev odbcinst1debian2 unixodbc)
apt-get -y install unixodbc-dev

# Se pasa a instalar Erlang
if [ -e otp_src_17.4.tar.gz ]; then
echo "Good! 'otp_src_17.4.tar.gz' already exists. Skipping download."
else
wget http://www.erlang.org/download/otp_src_17.4.tar.gz
fi
tar -xvzf otp_src_17.4.tar.gz

mv otp_src_17.4 erlang

cd erlang
./configure
make
make install

cd ..

##################################################################
# YAWS Installation

apt-get -y install libpam0g-dev

apt-get -y install cadaver

if [ -e yaws-1.99.tar.gz ]; then
echo "Good! 'yaws-1.99.tar.gz' already exists. Skipping download."
else
wget http://yaws.hyber.org/download/yaws-1.99.tar.gz
fi

tar -xvzf yaws-1.99.tar.gz

mv yaws-1.99.tar.gz yaws

cd yaws

# Solo se realiza cuando se descarga con git
# autoreconf -fi

./configure --sysconfdir=/etc
make 
make install

yaws --daemon --heart

cd ..

exit 0 

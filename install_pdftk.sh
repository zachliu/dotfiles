#!/bin/bash
# See https://askubuntu.com/questions/1028522/how-can-i-install-pdftk-in-ubuntu-18-04-and-later
# author: abu
# date:   July 3 2019 (ver. 1.1)
# description: bash script to install pdftk on Ubuntu 18.04 for amd64 machines
##############################################################################
#
# change to /tmp directory
cd /tmp
# download packages
wget http://launchpadlibrarian.net/340410966/libgcj17_6.4.0-8ubuntu1_amd64.deb \
 http://launchpadlibrarian.net/337429932/libgcj-common_6.4-3ubuntu1_all.deb \
 https://launchpad.net/ubuntu/+source/pdftk/2.02-4build1/+build/10581759/+files/pdftk_2.02-4build1_amd64.deb \
 https://launchpad.net/ubuntu/+source/pdftk/2.02-4build1/+build/10581759/+files/pdftk-dbg_2.02-4build1_amd64.deb


echo -e "Packages for pdftk downloaded\n\n"
# install packages
echo -e "\n\n Installing pdftk: \n\n"
sudo apt install ./libgcj17_6.4.0-8ubuntu1_amd64.deb \
    ./libgcj-common_6.4-3ubuntu1_all.deb \
    ./pdftk_2.02-4build1_amd64.deb \
    ./pdftk-dbg_2.02-4build1_amd64.deb
echo -e "\n\n pdftk installed\n"
echo -e "   try it in shell with: > pdftk \n"
# delete deb files in /tmp directory
rm ./libgcj17_6.4.0-8ubuntu1_amd64.deb
rm ./libgcj-common_6.4-3ubuntu1_all.deb
rm ./pdftk_2.02-4build1_amd64.deb
rm ./pdftk-dbg_2.02-4build1_amd64.deb

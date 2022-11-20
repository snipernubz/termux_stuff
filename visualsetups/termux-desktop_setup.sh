#!/bin/bash
#downloads and setups up termux-desktop, by adi1090x
# also installs firefox and optionally noVNC


git clone https://github.com/adi1090x/termux-desktop.git
echo "downloaded termux-desktop"
cd termux-desktop
echo -e "running termux-desktop install script"
chmod +x setup.sh
./setup.sh --install
pkg update
pkg install firefox


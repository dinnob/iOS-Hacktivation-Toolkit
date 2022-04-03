#!/bin/bash

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <https://www.gnu.org/licenses/>.


#COLOURS
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
NC="\e[0m"


###########################
#ROOT PRIVILEGES
###########################

if [[ $EUID -ne 0 ]]; then
        echo -e "$RED You don't have root privileges, execute the script as root.$NC"
        exit 1
fi

clear

###########################
#MENU
###########################

main_menu(){

echo -e "$GREEN"

echo " **************************************************"
echo " ************ iOS Hacktivation Toolkit ************"
echo -e " **************************************************$NC"
echo -e " [+]              $GREEN  Coded by SRS   $NC             [+]"
echo -e " [+] 		  $GREEN appsec@tuta.io$NC 	        [+]"
echo -e " [+]$GREEN  	  Co-developed by @johnponflanchan$NC      [+]"
echo -e " [+]$GREEN Thanks to$NC :$GREEN @exploit3dguy + @appletech752 $NC [+]"
echo -e " [+]$GREEN 		    & @iRogerosx 	       $NC [+]"

ActivationState=$(ideviceinfo | grep ActivationState | awk '{print $NF}')
MobileEquipmentIdentifier=$(ideviceinfo | grep 'MobileEquipmentIdentifier' | sed "s/^[ \t]*//"  | uniq | awk '{print $NF}')
DeviceName=$(ideviceinfo | grep DeviceName | awk '{print $NF}')
UniqueDeviceID=$(ideviceinfo | grep UniqueDeviceID | awk '{print $NF}')
SerialNumber=$(ideviceinfo | grep -w SerialNumber | awk '{print $NF}')
ProductType=$(ideviceinfo | grep ProductType | awk '{print $NF}')
ProductVersion=$(ideviceinfo | grep ProductVersion | awk '{print $NF}')

if test -z "$ActivationState" 
then
      echo ' --------------------------------------------------'
      echo -e "$RED              CANNOT CONNECT TO DEVICE             "
      echo -e "$RED    IF YOUR DEVICE IS IN DFU MODE, THIS IS OKAY$NC"
      echo ' --------------------------------------------------'
else
      echo ' --------------------------------------------------'
      echo -e "$GREEN Activation State : $ActivationState $NC"
      echo -e "$GREEN IMEI : $MobileEquipmentIdentifier $NC"
      echo -e "$GREEN Device Name : $DeviceName $NC"
      echo -e "$GREEN Serial Number : $SerialNumber $NC"
      echo -e "$GREEN Device : $ProductType $NC"
      echo -e "$GREEN Firmware : $ProductVersion $NC"
      echo ' --------------------------------------------------'
fi

echo -e "$YELLOW Select From Menu : $NC"
echo ' --------------------------------------------------'	
echo -e "$CYAN 1 : Complete Installation$NC"
echo -e "$CYAN 2 : Factory Reset (Restore iDevice)$NC"
echo -e "$CYAN 3 : Jailbreak (checkra1n)$NC"
echo -e "$CYAN 4 : Bypass iOS 13.0 > | 6S, SE, 7, 8, X$NC"
echo -e "$CYAN 5 : Bypass iOS 12.4.7 | 5S, 6$NC"
echo -e "$CYAN 6 : Bypass Ramdisk    | 5, 5C, iPad 4$NC"
echo -e "$CYAN 7 : SSH Shell$NC"
echo -e "$CYAN 0 : Exit$NC"
echo ' --------------------------------------------------'
read -p " Choose >  " ch

###########################
#INSTALL
###########################

if [ $ch = 1 ]; then

wget -O - https://assets.checkra.in/debian/archive.key | gpg --dearmor | sudo tee /usr/share/keyrings/checkra1n.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/checkra1n.gpg] https://assets.checkra.in/debian /' | sudo tee /etc/apt/sources.list.d/checkra1n.list
apt update
apt install -y python libcurl4-openssl-dev libplist-dev libzip-dev openssl libssl-dev libusb-1.0-0-dev libreadline-dev build-essential git make automake libtool pkg-config checkra1n sshpass
git clone 'https://github.com/libimobiledevice/libimobiledevice-glue'
git clone 'https://github.com/libimobiledevice/libirecovery'
git clone 'https://github.com/libimobiledevice/idevicerestore'
git clone 'https://github.com/libimobiledevice/usbmuxd'
git clone 'https://github.com/libimobiledevice/libimobiledevice'
git clone 'https://github.com/libimobiledevice/libusbmuxd'
git clone 'https://github.com/libimobiledevice/libplist'
git clone 'https://github.com/rcg4u/iphonessh.git'
git clone 'https://github.com/DanielVolt/ipwndfu.git'
cd ./libimobiledevice-glue && ./autogen.sh --without-cython && sudo make install && cd ..
cd ./libplist && ./autogen.sh --without-cython && sudo make install && cd ..
cd ./libusbmuxd && ./autogen.sh && sudo make install && cd ..
cd ./libimobiledevice && ./autogen.sh --without-cython && sudo make install && cd ..
cd ./usbmuxd && ./autogen.sh && sudo make install && cd ..
cd ./libirecovery && ./autogen.sh && sudo make install && cd ..
cd ./idevicerestore && ./autogen.sh && sudo make install && cd ..
tar xvf ./bypass_scripts/ramdisk_ipad4/ramdisk.tar.gz -C bypass_scripts/ramdisk_ipad4/
tar xvf ./bypass_scripts/ramdisk_iphone5/ramdisk.tar.gz -C bypass_scripts/ramdisk_iphone5/
tar xvf ./bypass_scripts/ramdisk_iphone5c/ramdisk.tar.gz -C bypass_scripts/ramdisk_iphone5c/
sudo ldconfig
echo ""
read -p "Complete! Back To Menu? [ Y / n ] : " check

if [ $check = "Y" ]; then
bash hacktivation.sh
elif [ $check = "y" ]; then
bash hacktivation.sh
elif [ $check = "Yes" ]; then
bash hacktivation.sh
elif [ $check = "yes" ]; then
bash hacktivation.sh
elif [ $check = "YES" ]; then
bash hacktivation.sh
else
exit 1
fi

###########################
#RESTORE
###########################

elif [ $ch = 2 ]; then

idevicerestore -e -l
echo ""
read -p "Complete! Back To Menu? [ Y / n ] : " check2

if [ $check2 = "Y" ]; then
bash hacktivation.sh
elif [ $check2 = "y" ]; then
bash hacktivation.sh
elif [ $check2 = "Yes" ]; then
bash hacktivation.sh
elif [ $check2 = "yes" ]; then
bash hacktivation.sh
elif [ $check2 = "YES" ]; then
bash hacktivation.sh
else
exit 1
fi

###########################
#CHECKRA1N
###########################

elif [ $ch = 3 ]; then

checkra1n
echo ""
read -p "Complete! Back To Menu? [ Y / n ] : " check3

if [ $check3 = "Y" ]; then
bash hacktivation.sh
elif [ $check3 = "y" ]; then
bash hacktivation.sh
elif [ $check3 = "Yes" ]; then
bash hacktivation.sh
elif [ $check3 = "yes" ]; then
bash hacktivation.sh
elif [ $check3 = "YES" ]; then
bash hacktivation.sh
else
exit 1
fi

###########################
#IOS 13 > MOBILEACTIVATIOND
###########################

elif [ $ch = 4 ]; then

bypass_scripts/mobileactivationd_13_x/./run.sh

echo""
read -p "Complete! Back To Menu? [ Y / n ] : " check4


if [ $check4 = "Y" ]; then
bash hacktivation.sh
elif [ $check4 = "y" ]; then
bash hacktivation.sh
elif [ $check4 = "Yes" ]; then
bash hacktivation.sh
elif [ $check4 = "yes" ]; then
bash hacktivation.sh
elif [ $check4 = "YES" ]; then
bash hacktivation.sh
else
exit 1
fi

elif [ $ch = 5 ]; then

bypass_scripts/mobileactivationd_12_4_7/./run.sh

###########################
#A6 bypass lol
###########################

elif [ $ch = 6 ]; then

cd bypass_scripts && chmod +x ./A6_menu.sh && bash A6_menu.sh

###########################
#SSH SHELL
###########################
elif [ $ch = 7 ]; then

echo ""
rm ~/.ssh/known_hosts >/dev/null 2>&1
pgrep -f 'tcprelay.py' | xargs kill >/dev/null 2>&1
python iphonessh/python-client/tcprelay.py -t 44:2222 >/dev/null 2>&1 &
sleep 2
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p 2222 mount -o rw,union,update /
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost -p 2222
pgrep -f 'tcprelay.py' | xargs kill >/dev/null 2>&1
echo ""
read -p "Complete! Back To Menu? [ Y / n ] : " check6

if [ $check7 = "Y" ]; then
bash hacktivation.sh
elif [ $check7 = "y" ]; then
bash hacktivation.sh
elif [ $check7 = "Yes" ]; then
bash hacktivation.sh
elif [ $check7 = "yes" ]; then
bash hacktivation.sh
elif [ $check7 = "YES" ]; then
bash hacktivation.sh
else
exit 1
fi
elif [ $ch == 0 ]; then
echo -e "$RED Program Exit ...$NC"
sleep 0.25
exit 1
else
echo "Option not found. Try again."
sleep 0.5
clear
main_menu
fi

}

if [ -f "hacktivation.sh" ]; then
main_menu;
else
echo " You need to run the script in the same folder the shell script is in."
echo " You can't just drag it into the Terminal. Exiting..."
exit 1
fi

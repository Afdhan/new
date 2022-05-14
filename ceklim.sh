#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);

clear
echo " "
echo "===========================================";
echo " ";
if [ -e "/root/log-limit.txt" ]; then
echo "User Who Violate The Maximum Limit";
echo "Time - Username - Number of Multilogin"
echo "-------------------------------------";
cat /root/log-limit.txt
else
echo " No user has committed a violation"
echo " "
echo " or"
echo " "
echo " The user-limit script not been executed."
fi
echo " ";
echo "===========================================";
echo " ";

#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
Blink='\e[5m'
yell='\e[33m'
lgreen='\e[92m'
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
apt update
apt install -y bzip2 gzip coreutils screen curl wget tcpdump dsniff grepcidr dnsutils -y
clear
if [ -f "/etc/v2ray/domain"]; then
echo "Script Already Installed"
exit 0
fi
clear
echo ""
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green Silahkan masukan sub domain anda $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -p " Hostname / Domain: " host
mkdir -p /etc/
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/tls
mkdir -p /etc/config-url
mkdir -p /etc/config-user
mkdir -p /etc/xray/conf
mkdir -p /etc/v2ray/conf
mkdir -p /etc/systemd/system/
mkdir -p /var/log/xray/
mkdir -p /var/log/v2ray/
mkdir /var/lib/premium-script;
touch /etc/xray/clients.txt
touch /etc/v2ray/clients.txt
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
echo "$host" > /etc/v2ray/domain
echo "$host" > /root/domain

clear
secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$gree Process Update & Upgrade Sedang Dijalankan  $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
apt-get update && apt-get upgrade -y && update-grub -y
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green  Process Update & Upgrade Selesai        $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green  ISSUE CERT & Install TROJAN GFW       $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
clear
wget https://raw.githubusercontent.com/Afdhan/new/main/inss-vt.sh && chmod +x inss-vt.sh && screen -S v2ray ./inss-vt.sh
#Instal Xray
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          Install XRAY              $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
clear
wget https://raw.githubusercontent.com/Afdhan/new/main/xray.sh && chmod +x xray.sh && screen -S xray ./xray.sh


rm -f /root/inss-vt.sh
rm -f /root/set-br.sh
rm -f /root/xray.sh

cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://worldssh.tech

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -O /etc/set.sh "https://raw.githubusercontent.com/Afdhan/new/main/set.sh"
chmod +x /etc/set.sh
history -c
clear
echo " "
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green  Installation has been completed!!      $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2

secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e ""
sleep 3
echo -e ""
rm -f /root/*.sh
rm -f /root/setup.sh
rm -f /root/.bash_history
echo -ne "[ ${yell}WARNING${NC} ] Reboot vps? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi


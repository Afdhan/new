#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);

clear
IP=$(wget -qO- ipinfo.io/ip);
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
MYIP=$(wget -qO- ipinfo.io/ip);
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
Login=Trial-`</dev/urandom tr -dc X-Z0-9 | head -c3`
hari="1"
Pass=`</dev/urandom tr -dc 0-9 | head -c3`

useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "===============================" | lolcat
echo -e "Username       : $Login "
echo -e "Password       : $Pass"
echo -e "===============================" | lolcat
echo -e "Domain         : ${domain}"
echo -e "Host           : $IP"
echo -e "ISP            : $ISP"
echo -e "CITY           : $CITY"
echo -e "OpenSSH        : 22"
echo -e "Dropbear       : 109, 143"
echo -e "SSL/TLS        : $ssl"
echo -e "SSH WS CDN     : 443, 8880"
echo -e "OVPN CDN       : 2082"
echo -e "Port Squid     : $sqd"
echo -e "OpenVPN        : TCP $ovpn http://$IP:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN        : UDP $ovpn2 http://$IP:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN        : SSL 442 http://$IP:81/client-tcp-ssl.ovpn"
echo -e "BadVPN         : 7100-7300"
echo -e "===============================" | lolcat
echo -e "Expired On     : $exp"
echo -e "===============================" | lolcat
echo -e "~ AutoScript WORLDSSH"

#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);

clear
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
IP=$(wget -qO- ipinfo.io/ip);
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"

clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null



cat > /etc/v2ray/$Login-ssh.json <<END
{
      "openssh": "22",
      "dropbear": "109, 143, 110",
      "stunnel": "222, 777",
      "wstls": "443",
      "wsntls": "8880",
      "wsntls2": "2095",
      "wsovpn": "2082",
      "squid": "8080, 3128",
      "ohps": "8181",
      "ohpd": "8282",
      "ohpv": "8383",
      "badvpn": "7100-7300"
 }
END


echo -e ""
echo -e "Thank You For Using Our Services"
echo -e "SSH & OpenVPN Account Info"
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
echo -e "Port SSH CDN   : 2082"
echo -e "Port Squid     : $sqd"
echo -e "OpenVPN        : TCP $ovpn http://$IP:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN        : UDP $ovpn2 http://$IP:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN        : SSL 442 http://$IP:81/client-tcp-ssl.ovpn"
echo -e "badvpn         : 7100-7300"
echo -e "===============================" | lolcat
echo -e "Expired On     : $exp"
echo -e "~ AutoScript WORLDSSH"

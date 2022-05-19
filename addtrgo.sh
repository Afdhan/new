#!/bin/bash
domain=$(cat /etc/v2ray/domain)
read -rp "Username: " -e user
egrep -w "^### $user" /usr/local/etc/xray/trojanws.json >/dev/null
if [ $? -eq 0 ]; then
echo -e "Username Sudah Ada"

exit 0
fi
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojanws.json
systemctl restart xray@trojanws
trojanlink="trojan-go://${uuid}@${domain}:443/?sni=${domain}&type=ws&host=${domain}&path=/WorldSSH&encryption=none#${user}"
echo -e "### $user $exp" >> /etc/trojan/trojango.conf
clear
echo -e "=================================" | lolcat
echo -e "VPN TYPE       : TROJAN GO"
echo -e "=================================" | lolcat
echo -e "Remarks        : ${user}"
echo -e "Host           : ${domain}"
echo -e "Port           : 443"
echo -e "Key            : ${user}"
echo -e "Path           : /WorldSSH"
echo -e "=================================" | lolcat
echo -e "Link           : ${trojangolink}"
echo -e "=================================" | lolcat
echo -e "Expired On     : $exp"
echo -e "=================================" | lolcat
echo -e "~ BY HTTPS://WORLDSSH.TECH"
echo -e ""

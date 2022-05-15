#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
clear
uuid=$(cat /proc/sys/kernel/random/uuid)
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
tr="$(cat ~/log-install.txt | grep -i Trojan | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "Password: " -e user
		user_EXISTS=$(grep -w $user /etc/trojan/akun.conf | wc -l)
        trg=$(grep -w "^### $user" /usr/local/etc/xray/trojanws.json | wc -l)
		if [[ ${user_EXISTS} == '1' || ${trg} == '1' ]]; then
			
	#		cat > /etc/v2ray/$user-tr.json <<END
                    #      {
                   #       "Username Sudah Ada"
                #          }
               #         END
			echo "username already used"
			exit 1
		fi
	done
read -p "Expired (days): " masaaktif
sed -i '/"'""password""'"$/a\,"'""$user""'"' /etc/trojan/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojanws.json
systemctl restart xray@trojanws
trojanglink="trojan-go://${uuid}@${domain}:443/?sni=${domain}&type=ws&host=${domain}&path=/WorldSSH&encryption=none#${user}"

echo -e "### $user $exp" >> /etc/trojan/akun.conf
systemctl restart trojan
#echo -e "\033[32m[Info]\033[0m Trojan-GFW Start Successfully !"
#sleep 2
trojanlink="trojan://${user}@${domain}:${tr}"
trojanlink2="trojan://${user}@${MYIP}:${tr}"


cat>/etc/v2ray/$user-tr.json<<EOF
[
      {
      "user": "${user}",
      "host": "${domain}",
      "port": "443",
      "uuid": "${user}"
     }
],
[
      {
      "user": "${user}",
      "host": "${domain}",
      "port": "443",
      "uuid": "${uuid}",
      "path": "/WorldSSH",
      "enc": "none",
      "type": "ws"
     }
]
EOF
clear
echo -e ""
echo -e "=============-Trojan-============" | lolcat
echo -e "Remarks        : ${user}"
echo -e "Host/IP        : ${domain}/${MYIP}"
echo -e "port           : ${tr}"
echo -e "Key            : ${user}"
echo -e "link1          : ${trojanlink}"
echo -e "link2	  	: ${trojanlink2}"
echo -e "trgo	  	: ${trojanglink}"
echo -e "=================================" | lolcat
echo -e "Expired On     : $exp"
echo -e "~ AutoScript WORLDSSH"

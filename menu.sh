#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
# VPS Information
#Domain
domain=$(cat /etc/v2ray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
#Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )

declare -A nama_hari
nama_hari[Monday]="Senin"
nama_hari[Tuesday]="Selasa"
nama_hari[Wednesday]="Rabu"
nama_hari[Thursday]="Kamis"
nama_hari[Friday]="Jumat"
nama_hari[Saturday]="Sabtu"
nama_hari[Sunday]="Minggu"
hari_ini=`date +%A`


declare -A nama_bulan
nama_bulan[Jan]="Januari"
nama_bulan[Feb]="Februari"
nama_bulan[Mar]="Maret"
nama_bulan[Apr]="April"
nama_bulan[May]="Mei"
nama_bulan[Jun]="Juni"
nama_bulan[Jul]="Juli"
nama_bulan[Aug]="Agustus"
nama_bulan[Sep]="September"
nama_bulan[Oct]="Oktober"
nama_bulan[Nov]="November"
nama_bulan[Dec]="Desember"
bulan_ini=`date +%b`

hari=${nama_hari[$hari_ini]}
jam=$(TZ='Asia/Jakarta' date +%R)
tnggl=$(date +"%d")
bln=${nama_bulan[$bulan_ini]}
thn=$(date +"%Y")
clear 


echo ""
echo ""
echo ""
echo -e "${red}══════════════════════════════════════════════════════════${NC}"
echo -e "                    WORLDSSH TEAM " | lolcat
echo -e "${red}══════════════════════════════════════════════════════════${NC}"
echo -e " ${blue}Local TZ               :  Asia/Jakarta ${NC}"
echo -e " ${blue}Time                   :  $jam WIB ${NC}"
echo -e " ${blue}Day                    :  $hari ${NC}"
echo -e " ${blue}Date                   :  $tnggl $bln $thn ${NC}"
echo -e "${red}══════════════════════════════════════════════════════════${NC}"

echo -e "                  • SERVER INFO •                 " | lolcat
echo -e "${red}══════════════════════════════════════════════════════════${NC}"
echo -e "${blue}>${NC}\e[33m CPU Model              \e[0m: $cname"
echo -e "${blue}>${NC}\e[33m CPU Frequency          \e[0m: $freq MHz"
echo -e "${blue}>${NC}\e[33m Number Of Cores        \e[0m:  $cores"
echo -e "${blue}>${NC}\e[33m CPU Usage              \e[0m:  $cpu_usage"
echo -e "${blue}>${NC}\e[33m Operating System       \e[0m:  "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`	
echo -e "${blue}>${NC}\e[33m Kernel                 \e[0m:  `uname -r`"
echo -e "${blue}>${NC}\e[33m Total Amount Of RAM    \e[0m:  $tram MB"
echo -e "${blue}>${NC}\e[33m Used RAM               \e[0m:  $uram MB"
echo -e "${blue}>${NC}\e[33m Free RAM               \e[0m:  $fram MB"
echo -e "${blue}>${NC}\e[33m System Uptime          \e[0m:  $uptime "
echo -e "${blue}>${NC}\e[33m ISP Name               \e[0m:  $ISP"
echo -e "${blue}>${NC}\e[33m Domain                 \e[0m:  $domain"	
echo -e "${blue}>${NC}\e[33m IP Vps                 \e[0m:  $IPVPS"	
echo -e "${blue}>${NC}\e[33m City                   \e[0m:  $CITY"
echo -e "${blue}>${NC}\e[33m TimeZone               \e[0m:  $WKT"
echo -e "${blue}>${NC}\e[33m Day                    \e[0m:  $DAY ($hari)"
echo -e "${blue}>${NC}\e[33m Date                   \e[0m:  $DATE"
echo -e "${red}══════════════════════════════════════════════════════════${NC}"
echo -e "${red}══════════════════════════════════════════════════════════${NC}"
echo -e "\e[33m Traffic\e[0m        \e[33mToday       Yesterday      Month   "
echo -e "\e[33m Download\e[0m       $dtoday     $dyest        $dmon   \e[0m"
echo -e "\e[33m Upload\e[0m         $utoday     $uyest        $umon   \e[0m"
echo -e "\e[33m Total\e[0m       \033[0;36m   $ttoday     $tyest       $tmon  \e[0m "
echo -e "${red}══════════════════════════════════════════════════════════${NC}"
echo -e "${red}══════════════════════════════════════════════════════════${NC}"

echo -e "                 • TUNNEL MENU •                 " | lolcat
echo -e "${red}══════════════════════════════════════════════════════════${NC}"
echo -e   ""
echo -e " 1 ⸩ SSH & OpenVPN Menu"
echo -e " 2 ⸩ Wireguard Menu"
echo -e " 3 ⸩ SSR & SS Menu"
echo -e " 4 ⸩ XRAY Menu"
echo -e " 5 ⸩ V2RAY Menu"
echo -e " 6 ⸩ Trojan GFW Menu"
echo -e " 7 ⸩ Status Service"
echo -e " 8 ⸩ VPS Information"
echo -e " 9 ⸩ Clear RAM Cache"
echo -e " 10 ⸩ REBOOT"
echo -e   ""
echo -e "${red}══════════════════════════════════════════════════════════${NC}"
echo -e " 0 ⸩ System Menu"
echo -e " x ⸩ Exit"
echo -e "${red}══════════════════════════════════════════════════════════${NC}"
echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; tessh ;;
2) clear ; wgg ;;
3) clear ; sssr ;;
4) clear ; wss ;;
5) clear ; wss ;;
6) clear ; trj ;;
7) clear ; status ;;
8) clear ; about ;;
9) clear ; clearcache ;;
10) clear ; reboot ;;
0) clear ; m-system ;;
x) exit ;;
esac

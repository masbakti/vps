#!/bin/bash

read -p "Username Akun Baru : " Login
read -p "Password Untuk [$Login]: " Pass
read -p "Berapa hari akun [$Login] aktif: " masaaktif

IP=`dig +short myip.opendns.com @resolver1.opendns.com`
useradd -g users -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Informasi SSH"
echo -e "=========-account-=========="
echo -e "Host/IP: $IP"
echo -e "Port (Dropbear): 109, 110, 443"
echo -e "Squid Proxy : 8080"
echo -e "Username: $Login "
echo -e "Password: $Pass"
echo -e "-----------------------------"
echo -e "Aktif Sampai: `date -d "$exp" +"%d-%b-%Y"`"
echo -e "==========================="

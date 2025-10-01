#!/bin/bash
clear
echo -e "\e[1;33m=======================================================================\033[0m"
echo -n $(hostname) "   " 
cat /etc/os-release | grep PRETTY_NAME | sed 's/PRETTY_NAME=//'
uptime
echo -e "\e[1;33m-----CPU---------------------------------------------------------------\033[0m"
lscpu | grep -e "Model name" -e "CPU(s):" | grep -v "NUMA"
echo -e "\e[1;33m-----MEM & SWAP--------------------------------------------------------\033[0m"
free -h
echo -e "\e[1;33m-----top 5 процессов по CPU-------------------------------------------\033[0m"
ps -aux | grep -v "%CPU" | awk '{arr[$11]+=$3}END {for (i in arr) print arr[i], "% \t" , i}' | sort -k 1 -n -r | head -n 5
echo -e "\e[1;33m-----top 5 процессов по MEM-------------------------------------------\033[0m"
ps -e -o rss,command | awk '{arr[$2]+=$1}END {for (i in arr) print arr[i]/1024"Mb \t" i}' | sort -k 1 -n -r | head -n 5
echo -e "\e[1;33m-----количество Zombie процессов---------------------------------------\033[0m"
ps -xal | grep defunct | awk '{arr[$13]+=1}END {for (i in arr) print arr[i], "шт." , i}' | sort -k 1 -n -r
echo -e "\e[1;33m-----memory type------------------------------------------------------\033[0m"
sudo dmidecode --type memory | grep -v "Unknown" | grep -e "Bank Loc" -e "GB" -e "Memory Speed" -e "DDR" -e "Memory Dev" -e "Part" | grep -v Maximum | grep -v "Not Specified"


echo "-----------------------------------------------------------------------"

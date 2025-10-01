#!/bin/bash
#------functions--------
getattr(){
devattr=$(udevadm info -n $device)
result=""
while read attr; do
    if [[ $attr == *"$1"* ]];
    then
        result=${attr:`expr index "$attr" "="`}
    fi
done<<<$devattr
echo $result;
}
#-----------------------

ttyACM=$(ls /dev | grep tty)
echo " "
echo "---------------------------------------------"
echo  -e "\033[30;107m    Список устройств tty     \033[0m"
Counter=0
while read device; do
    vendorid=$(getattr "VENDOR_ID=")
    if ((${#vendorid} > 0)); then
        devname=$(getattr "DEVNAME=")
        let Counter=Counter+1
        temp=$Counter" ";Count=${temp:0:2}
        temp=$device"          ";dev=${temp:0:8}
        model=$(getattr "_MODEL=")
        vendor=$(getattr "_VENDOR=")
        serial=$(getattr "SERIAL_SHORT=")
        modelid=$(getattr "MODEL_ID=")

	#colors
        if [[ $devname == *"$device"* ]];
        then	color="\033[32m"
        else	color="\033[1;33m"
        fi
        if [[ $vendor == *"ATOL"* ]];
        then	vendorcolor="\033[1;36m"
        else	vendorcolor="\033[1;33m"
        fi
	echo -e "\033[1;33;40m$Count  \033[32;40m$dev\033[0m dev=$color$devname\033[0m ID vendor:model=$vendorcolor$vendorid:$modelid\033[0m model=$vendorcolor$model ($vendor)\033[0m ser.=$vendorcolor$serial\033[0m"
    fi
done<<<$ttyACM

#show files in /etc/udev/rules.d
echo " "
echo  -e "\033[30;107m  Правила /etc/udev/rules.d  \033[0m"
search_dir="/etc/udev/rules.d"
for entry in "$search_dir"/*
do
    echo -e "\033[1;33m$entry\033[0m"
    cat $entry
    echo "---------------------------------------------"
done

#show links in /opt/sber
echo " "
echo  -e "\033[30;107m  Ссылки /opt/sber*/ttyS99   \033[0m"
search_dir="/opt/sber"
for entry in "$search_dir"*
do
    echo -e "\033[1;33m$entry\033[0m"
    cd $entry
    ls -l ./tty*
    echo "---------------------------------------------"
done
echo " "
echo -e "\033[1;33;44mПример команды создания ссылки  ln /dev/ttyACM20 /opt/sber/ttyS99 -s\033[0m"
echo " "
echo " "

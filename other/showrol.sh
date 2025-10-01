#!/bin/bash

#получить имена последних N файлов----------------------------------------------------------------------------------------------
Nfiles=10
echo " "
echo "Анализ лог файлов ROL за последние $Nfiles часов"
echo "------------------------------------------------"


#Удаление ранее скачанных лог файлов -------------------------------------------------------------------------------------------
declare -a file
for ((i=0;i<$Nfiles;i++))
do
    file[i]=$(date -d "-$i hour" +spy_time_%Y-%m-%d_%H.log)
    if [ -f ./${file[i]} ] ; then
#        echo "Удаление, ранее скачанного лога ${file[i]}"
	rm ./${file[i]}
    fi
done


#скачать файлы логов-----------------------------------------------------------------------------------------------------------
/bin/echo -en "\e[1;33m Введите короткое имя сервера: \e[0m"
read -p '' servername
echo -n "Загрузка:"
for ((i=0;i<$Nfiles;i++))
do
    # echo "получение ${file[i]}"
    echo -n "#"
    tmpvar="-q http://$servername/spy/logs/${file[i]}"
    wget $tmpvar
done
echo " "


#анализ логов--------------------------------------------------------------------------------------------------------------------
/bin/echo -en "\e[1;33m Введите последние цифры IMEI (не менее 5): \e[0m"
read -p '' IMEI

for ((i=0;i<$Nfiles;i++))
do
    filename="./${file[i]}"
    counter=0
    while read str; do
	if [[ $str == *"$IMEI"*"в БД добавлена"* ]];
        then
	    let counter=counter+1
	    laststr=$str
	fi
    done < $filename
    
    DT=${laststr:0:16}
    IMEIfull=${laststr:20:15}
    DF=${laststr:36:4}"."${laststr:40:2}"."${laststr:42:2}" "${laststr:44:2}":"${laststr:46:2}" - "${laststr:59:2}":"${laststr:61:2}
    if [ $counter -eq 0 ]
    then
        echo "лог ${file[i]} нет записей по IMEI $IMEI"
    else
        echo -e "лог ${file[i]} \033[1;32m$counter\033[0m записей по IMEI \033[1;32m$IMEIfull\033[0m, последняя за период \033[1;36m$DF\033[0m загружена $DT"
    fi
done


#Удаление ранее скачанных лог файлов -----------------------------------------------------------------------------------------------
for ((i=0;i<$Nfiles;i++))
do
    file[i]=$(date -d "-$i hour" +spy_time_%Y-%m-%d_%H.log)
    if [ -f ./${file[i]} ] ; then
#        echo "Удаление, ранее скачанного лога ${file[i]}"
	rm ./${file[i]}
    fi
done

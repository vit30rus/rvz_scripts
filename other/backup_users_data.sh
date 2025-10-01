#!/bin/bash
clear
homefolder="/home/agat.local/"

homehiddentargets=('
.config/google-chrome/Default/Login* 
.config/google-chrome/Default/Bookmarks 
.thunderbird 
')

hosttargets='
/opt/sberinkass/refs 
/opt/sber 
/etc/udev/rules.d
'

#--------------------------------------------
for bkpath in $(ls $homefolder)
do
    bktargets=""

    for i in ${homehiddentargets}
    do
        bktargets="$bktargets $homefolder$bkpath/$i"
    done

    bktargets="$bktargets $homefolder$bkpath/*"
    bktargets="$bktargets $hosttargets"

    bkcommand="tar -cp -f $(date "+%Y-%m-%d_%H-%M-%S")_$(hostname -s)_$bkpath.tar $bktargets"
    $($bkcommand)
    echo " ======================================================================== "

done

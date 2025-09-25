#!/bin/sh
grepstring="username, ip, etc"

while true 
do
clear
tail -n 1000 /var/squidGuard/log/block.log | grep $grepstring | tail -n 30
sleep 2
done

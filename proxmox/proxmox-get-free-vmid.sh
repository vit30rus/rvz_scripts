#!/bin/bash
#get free vmid from range. (201-299 in this code)
targetvmid=0
vmidlist=$(qm list | awk '{print $1}' | grep -v VMID)
for ((vmid=201; vmid<300; vmid++))
do
#       echo searching $vmid in $vmidlist
       if [[ $vmidlist != *"$vmid"* ]]; then
               targetvmid=$vmid
               break
       fi
done
echo target vmid = $targetvmid

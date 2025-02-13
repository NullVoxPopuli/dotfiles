#!/usr/bin/env bash

# Notes:
#  List which disks are known to the OS:
#    - lsblk -io KNAME,TYPE,SIZE,MODEL
#    - hwinfo --disk
#    - sudo lshw -class disk
#    - lsblk
#
#  List mounts
#    - findmnt -lo source,target,fstype,label,options,used

sudo mkdir -p /mnt/ramdisk
sudo mount -o size=8G -t tmpfs none /mnt/ramdisk

echo "To unmount:" 
echo -e "\tsudo umount /mnt/ramdisk"
echo ""
echo "Previous pnpm store:"
echo -e "\t$(pnpm config get store-dir)"
echo ""
echo -e "\tTo restore:"
echo -e "\t\tpnpm config set --global store-dir $(pnpm config get store-dir)"

# TODO: copy store into ramdisk?
# TODO: download more RAM (store is 9.5G rn in ~/.pnpm-store)
pnpm config set store-dir /mnt/ramdisk/.pnpm-store 

echo ""
echo "New pnpm store at:"
echo "\t$(pnpm config get store-dir)

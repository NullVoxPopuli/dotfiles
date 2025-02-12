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

# To unmount: 
# sudo umount /mnt/ramdisk

# TODO: copy store into ramdisk?
# TODO: download more RAM (store is 9.5G rn in ~/.pnpm-store)
# pnpm config set store-dir /mnt/ramdisk 

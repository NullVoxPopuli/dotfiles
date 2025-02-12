#!/usr/bin/env bash
# SIZE=8192 = 8GB


SIZE=8192  
DISKNAME=RamDisk
DISK_ID=$(hdiutil attach -nomount ram://$((SIZE * 2048)) | xargs)
# diskutil eraseDisk HFS+ "$DISKNAME" $DISK_ID
diskutil eraseDisk APFS "$DISKNAME" $DISK_ID

# TODO: copy store into ramdisk?
# TODO: download more RAM (store is 9.5G rn in ~/.pnpm-store)
# pnpm config set store-dir /Volumes/RamDisk/pnpm-store 

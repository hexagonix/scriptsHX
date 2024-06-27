#!/bin/bash 

buildImageOnLinux()
{

echo -e "Starting Hexagonix on Linux builder mod version $MOD_VER...\n" >> $LOG

dd status=none bs=512 count=$TEMP_IMAGE_SIZE if=/dev/zero of=temp.img >> $LOG || buildError

if [ ! -e hexagonix.img ] ; then

echo -e "> Building image that will receive system files...\n" >> $LOG

dd status=none bs=$DISK_IMAGE_SIZE count=1 if=/dev/zero of=$IMAGE_FILENAME >> $LOG || buildError

fi

echo "> Copying bootloader (Saturno) to image..." >> $LOG

dd status=none conv=notrunc if=$BUILD_DIRECTORY/saturno.img of=temp.img >> $LOG || buildError

echo "> Mounting the image..." >> $LOG

mkdir -p $MOUNT_POINT_DIRECTORY && mount -o loop -t vfat temp.img $MOUNT_POINT_DIRECTORY/ || buildError

}

. $MOD_DIR/common.hx

MOD_VER="0.1"

buildImageOnLinux
#!/bin/bash

buildImageOnBSD()
{

echo -e "Starting Hexagonix on BSD builder mod version $MOD_VER...\n" >> $LOG

# Reserved sectors = 16
# Fats = 2
# Root entries = 512
# Sectors per fat = 16
# Sectores per track = 63
# Heads = 255
# Hidden sectores = 0
# Total sectors = 92160

newfs_msdos -C 45m -F 16 -B $BUILD_DIRECTORY/saturno.img temp.img

if [ ! -e hexagonix.img ] ; then

echo -e "> Building image that will receive system files...\n" >> $LOG

newfs_msdos -C 90m -F 16 hexagonix.img

fi

mdconfig -a -t vnode -f temp.img -o force -u 4

echo "> Mounting the image..." >> $LOG

mkdir -p $MOUNT_POINT_DIRECTORY && mount_msdosfs /dev/md4 $MOUNT_POINT_DIRECTORY/ || buildError

}

. $MOD_DIR/common.hx

MOD_VER="0.1"

buildImageOnBSD
#!/bin/bash

diskBuilder()
{

startBuildLog

echo -e "Starting Hexagonix disk builder mod version $MOD_VER...\n" >> $LOG

if test "`whoami`" != "root" ; then

sureq

exit

fi

# Now the system files will be generated...

callHXMod systemBuilder

# Now the system image will be prepared...

echo -e "\e[1;94mBuilding system image...\e[0m"
echo

echo -e "\n----------------------------------------------------------------------\n" >> $LOG
echo -e "\nBuild a Hexagonix disk image... {" >> $LOG
echo -e "\n> Building temporary image for file manipulation...\n" >> $LOG

# Now let's check which system is the host, to adapt the disk image creation logic for each one.
# Supported so far: Linux and FreeBSD (FreeBSD in development)

if [ $HOST == "LINUX" ]; then

callHXMod buildOnLinux

fi

if [ $HOST == "BSD" ]; then

callHXMod buildOnBSD

fi

# From now on, the logic is the same for all supported host systems

echo -e "> Copying system files to the image...\n" >> $LOG

cp $BUILD_DIRECTORY/*.man $MOUNT_POINT_DIRECTORY >> $LOG || buildError
cp $BUILD_DIRECTORY/*.asm $MOUNT_POINT_DIRECTORY >> $LOG
cp $BUILD_DIRECTORY/*.s $MOUNT_POINT_DIRECTORY >> $LOG
cp $BUILD_DIRECTORY/*.cow $MOUNT_POINT_DIRECTORY >> $LOG || buildError
cp $BUILD_DIRECTORY/bin/* $MOUNT_POINT_DIRECTORY >> $LOG || buildError
cp $BUILD_DIRECTORY/hboot $MOUNT_POINT_DIRECTORY >> $LOG || buildError

# License must be copied

cp Dist/man/LICENSE $MOUNT_POINT_DIRECTORY >> $LOG || buildError

# Now copy HBoot modules

if [ -e $BUILD_DIRECTORY/Spartan.mod ] ; then

cp $BUILD_DIRECTORY/*.mod $MOUNT_POINT_DIRECTORY/ >> $LOG

fi

cp $BUILD_DIRECTORY/etc/* $MOUNT_POINT_DIRECTORY >> $LOG || buildError
cp $BUILD_DIRECTORY/*.ocl $MOUNT_POINT_DIRECTORY >> $LOG || buildError

# If the image should contain a copy of the FreeDOS files for testing...

if [ -e DOS ] ; then

cp DOS/*.* $MOUNT_POINT_DIRECTORY/

fi

# Now it will be checked whether any font should be included in the image
#
# If the default font file is available, use this information as a switch to 
# turn on the copy

echo -n "> Checking if there are graphic fonts to copy..." >> $LOG

if [ -e $BUILD_DIRECTORY/aurora.fnt ] ; then

echo -e " [Yes]\n" >> $LOG

cp $BUILD_DIRECTORY/*.fnt $MOUNT_POINT_DIRECTORY/ || buildError

fi

if [ ! -e $BUILD_DIRECTORY/aurora.fnt ] ; then

echo -e " [No]\n" >> $LOG

fi

callHXMod contribChecker

sleep 1.0 || buildError

echo "> Unmounting the image..." >> $LOG

umount $MOUNT_POINT_DIRECTORY >> /dev/null || buildError

if [ "$HOST" == "BSD" ]; then

mdconfig -d -u 4

fi

if [ "$HOST" == "UNIX" ]; then

lofiamd -d /dev/lofi/1

fi

echo "> Mounting the final image..." >> $LOG

echo "  * Copying temporary image to final image..." >> $LOG

dd status=none conv=notrunc if=temp.img of=$IMAGE_FILENAME seek=1 >> $LOG || buildError

echo "  * Copying MBR and partition table to image..." >> $LOG

dd status=none conv=notrunc if=$BUILD_DIRECTORY/mbr.img of=$IMAGE_FILENAME >> $LOG || buildError

echo "> Removing temporary files and folders, as well as binaries that are no longer needed..." >> $LOG
echo >> $LOG

rm -rf $MOUNT_POINT_DIRECTORY $BUILD_DIRECTORY temp.img >> $LOG

if test $VERBOSE -e 0; then

clear

elif test $VERBOSE -e 1; then

echo

fi

echo "> Moving files to final location..." >> $LOG

mv hexagonix.img $IMAGE_PATH/$IMAGE_FILENAME

echo "> Creating .vdi image from raw image..." >> $LOG

qemu-img convert -O vdi $IMAGE_PATH/$IMAGE_FILENAME $IMAGE_PATH/$(basename $IMAGE_FILENAME .img).vdi

# Let's now change the image ownership to a regular user

echo "> Adjusting file permissions (needed for git)..." >> $LOG

chown $IMAGE_PATH/$IMAGE_FILENAME --reference=$IMAGE_PATH/README.md
chown $IMAGE_PATH/$(basename $IMAGE_FILENAME .img).vdi --reference=$IMAGE_PATH/README.md

echo -e "\n} Hexagonix disk images built successfully.\n" >> $LOG

MSG="Build the Hexagonix"

banner

infoBuild

showCreateInstallerInfo

finishBuildLog

mv log.log $IMAGE_PATH/log.log
chown $IMAGE_PATH/log.log --reference=$IMAGE_PATH/README.md

exit

}

. $MOD_DIR/common.hx
. $MOD_DIR/logUtils.hx
. $MOD_DIR/buildInfo.hx

MOD_VER="0.1"

diskBuilder


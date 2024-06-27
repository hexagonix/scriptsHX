#!/bin/bash
#
#*************************************************************************************************
#
# 88                                                                                88
# 88                                                                                ""
# 88
# 88,dPPPba,   ,adPPPba, 8b,     ,d8 ,adPPPPba,  ,adPPPb,d8  ,adPPPba,  8b,dPPPba,  88 8b,     ,d8
# 88P'    "88 a8P     88  `P8, ,8P'  ""     `P8 a8"    `P88 a8"     "8a 88P'   `"88 88  `P8, ,8P'
# 88       88 8PP"""""""    )888(    ,adPPPPP88 8b       88 8b       d8 88       88 88    )888(
# 88       88 "8b,   ,aa  ,d8" "8b,  88,    ,88 "8a,   ,d88 "8a,   ,a8" 88       88 88  ,d8" "8b,
# 88       88  `"Pbbd8"' 8P'     `P8 `"8bbdP"P8  `"PbbdP"P8  `"PbbdP"'  88       88 88 8P'     `P8
#                                               aa,    ,88
#                                                "P8bbdP"
#
#                    Sistema Operacional Hexagonix - Hexagonix Operating System
#
#                         Copyright (c) 2015-2024 Felipe Miguel Nery Lunkes
#                        Todos os direitos reservados - All rights reserved.
#
#*************************************************************************************************
#
# Português:
#
# O Hexagonix e seus componentes são licenciados sob licença BSD-3-Clause. Leia abaixo
# a licença que governa este arquivo e verifique a licença de cada repositório para
# obter mais informações sobre seus direitos e obrigações ao utilizar e reutilizar
# o código deste ou de outros arquivos.
#
# English:
#
# Hexagonix and its components are licensed under a BSD-3-Clause license. Read below
# the license that governs this file and check each repository's license for
# obtain more information about your rights and obligations when using and reusing
# the code of this or other files.
#
#*************************************************************************************************
#
# BSD 3-Clause License
#
# Copyright (c) 2015-2024, Felipe Miguel Nery Lunkes
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# $HexagonixOS$

function main() {

diskBuilder

}

function diskBuilder() {

callHXMod logUtils startBuildLog

echo -e "Starting Hexagonix disk builder mod version $MOD_VER...\n" >> $LOG

if test "`whoami`" != "root" ; then

callHXMod common suRequired

exit

fi

# Now the system files will be generated...

callHXMod systemBuilder

# Now the system image will be prepared...

echo -e "\e[1;94mBuilding system image...\e[0m\n"

echo -e "\n----------------------------------------------------------------------\n" >> $LOG
echo -e "Build a Hexagonix disk image... {" >> $LOG
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

cp $BUILD_DIRECTORY/*.man $MOUNT_POINT_DIRECTORY >> $LOG || callHXMod common buildError
cp $BUILD_DIRECTORY/*.asm $MOUNT_POINT_DIRECTORY >> $LOG
cp $BUILD_DIRECTORY/*.s $MOUNT_POINT_DIRECTORY >> $LOG
cp $BUILD_DIRECTORY/*.cow $MOUNT_POINT_DIRECTORY >> $LOG || callHXMod common buildError
cp $BUILD_DIRECTORY/bin/* $MOUNT_POINT_DIRECTORY >> $LOG || callHXMod common buildError
cp $BUILD_DIRECTORY/hboot $MOUNT_POINT_DIRECTORY >> $LOG || callHXMod common buildError

# License must be copied

cp Dist/man/LICENSE $MOUNT_POINT_DIRECTORY >> $LOG || callHXMod common buildError

# Now copy HBoot modules

if [ -e $BUILD_DIRECTORY/Spartan.mod ] ; then

cp $BUILD_DIRECTORY/*.mod $MOUNT_POINT_DIRECTORY/ >> $LOG

fi

cp $BUILD_DIRECTORY/etc/* $MOUNT_POINT_DIRECTORY >> $LOG || callHXMod common buildError
cp $BUILD_DIRECTORY/*.ocl $MOUNT_POINT_DIRECTORY >> $LOG || callHXMod common buildError

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

cp $BUILD_DIRECTORY/*.fnt $MOUNT_POINT_DIRECTORY/ || callHXMod common buildError

fi

if [ ! -e $BUILD_DIRECTORY/aurora.fnt ] ; then

echo -e " [No]\n" >> $LOG

fi

callHXMod contribChecker

sleep 1.0 || callHXMod common buildError

echo "> Unmounting the image..." >> $LOG

umount $MOUNT_POINT_DIRECTORY >> /dev/null || callHXMod common buildError

if [ "$HOST" == "BSD" ]; then

mdconfig -d -u 4

fi

if [ "$HOST" == "UNIX" ]; then

lofiamd -d /dev/lofi/1

fi

echo "> Mounting the final image..." >> $LOG

echo "  * Copying temporary image to final image..." >> $LOG

dd status=none conv=notrunc if=temp.img of=$IMAGE_FILENAME seek=1 >> $LOG || callHXMod common buildError

echo "  * Copying MBR and partition table to image..." >> $LOG

dd status=none conv=notrunc if=$BUILD_DIRECTORY/mbr.img of=$IMAGE_FILENAME >> $LOG || callHXMod common buildError

echo -e "> Removing temporary files and folders, as well as binaries that are no longer needed...\n" >> $LOG

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

callHXMod common banner
callHXMod buildInfo infoBuild
callHXMod logUtils showCreateInstallerInfo
callHXMod logUtils finishBuildLog

mv log.log $IMAGE_PATH/log.log
chown $IMAGE_PATH/log.log --reference=$IMAGE_PATH/README.md

exit

}

# Imports

. $MOD_DIR/macros.hx

# Constants

MOD_VER="0.2"

main $1


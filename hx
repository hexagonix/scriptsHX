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

# $PORTUGUÊS$
#
# Esse script deve ficar na raiz do projeto
#
# Esse script foi desenvolvido para rodar sobre o Linux e versão do QEMU para Linux.
# A versão atual é totalmente compatível com o ambiente WSL 2 (e apenas a versão 2).
# Aviso! Até o momento, o script não é compatível com a geração do sistema sobre o
# FreeBSD. Entretanto, já é compatível para a execução de máquinas virtuais. O suporte
# total ao FreeBSD está a caminho.
#
#
# $ENGLISH$
#
# This script must be in the root of the project
#
# This script was developed to run on Linux and the Linux version of QEMU.
# The current version is fully compatible with the WSL 2 environment (and version 2 only).
# Warning! At this time, the script does not support system generation over FreeBSD.
# However, it is already supported for running virtual machines. The full support to
# FreeBSD is on the way.

# Help section and information about hx

showMainHelp() {

case $PT2 in

-v) showVirtualMachineHelp; exit;;
-i) showBuildHelp; exit;;

esac 

echo
echo -e "hx $HX_VERSION help:"
echo
echo -e "\e[1;94mMain\e[0m available parameters:"
echo
echo -e "\e[1;32m-v\e[0m  - Start a virtual machine. \e[1;32mUse 'hx -h -v' to learn more\e[0m"
echo -e "\e[1;32m-i\e[0m  - Build disk image. \e[1;32mUse 'hx -h -i' to learn more\e[0m"
echo -e "\e[1;32m-u\e[0m  - Update all repositories with server (current branch)"
echo -e "\e[1;32m-un <branch>\e[0m - Switch branch to <branch> and update all repositories"
echo -e "\e[1;32m-ui\e[0m - Sync Hexagonix images with the official repository"
echo -e "\e[1;32m-br\e[0m - Get information about current used branch"
echo -e "\e[1;32m-m\e[0m  - Clone repositories to location and configure build environment"
echo -e "\e[1;32m-c\e[0m  - Clear system tree binary and configuration files"
echo
echo  "See the complete documentation at: https://github.com/hexagonix/Doc"
echo

}

showVirtualMachineHelp()
{

echo
echo "hx $HX_VERSION help topics"
echo
echo -e "Start a Hexagonix virtual machine. The available parameters are\e[1;31m (default hx)*\e[0m:"
echo -e "\e[1;32m hx\e[0m        - Start virtual machine"
echo -e "\e[1;32m hx.wsnd\e[0m   - Start virtual machine without sound mode"
echo -e "\e[1;32m hx.serial\e[0m - Start virtual machine with no serial output"
echo -e "\e[1;32m hx.p3\e[0m     - Start virtual machine with a legacy processor (Pentium III)"
echo -e "\e[1;32m hx.bsd\e[0m    - Start BSD host compatible virtual machine"
echo -e "\e[1;31m* The 'hx' option will be selected if no parameter is passed after '-v'!\e[0m"

}

showBuildHelp()
{

echo
echo "hx $HX_VERSION help topics"
echo
echo -e "Build disk image. The available parameters are\e[1;31m (default hx)*\e[0m:"
echo -e "\e[1;32m hx\e[0m      - Build disk image with Hexagonix"
echo -e "\e[1;32m hx.test\e[0m - Build test disk image with Hexagonix"
echo -e "\e[1;31m* The 'hx' option will be selected if no parameter is passed after '-i'!\e[0m"

}

showVersion() {


echo -e "hx: Hexagonix build utility version $HX_VERSION"
echo
echo -e "\e[0mCopyright (c) 2015-2024 Felipe Miguel Nery Lunkes\e[0m"
echo -e "hx is licenced under BSD-3-Clause and comes with no warranty."
echo

}

parametersRequired(){

echo
echo -e "You must provide at least one \e[1;94mvalid\e[0m parameter."

showMainHelp

}

#-------------------------------- Division --------------------------------#

# Collective build section of system components

manageBuild()
{

getBuildInformation

case $PT2 in

hx) setImageBuildOnLinux; exit;;
hx.teste) prepImagemHexagonixTeste; exit;;
bsd) setImageBuildOnBSD; exit;;
UNIX) setImageBuildOnUNIXSolaris; exit;;
*) setImageBuildOnLinux; exit;; # Assumir hx -i hx

esac

}

manageComponentConstruction()
{

mkdir -p $DISTRO_DIRECTORY
mkdir -p $DISTRO_DIRECTORY/bin
mkdir -p $DISTRO_DIRECTORY/etc

case $PT2 in

hexagon) buildHexagonKernel; exit;;
HBoot) buildHBoot; exit;;
saturno) buildSaturnoBootLoader; exit;;
unixland) buildUnixUtil; exit;;
andromedaland) buildAndromedaApplications; exit;;
hexagonix) hexagonix; exit;;
hx) buildAllComponents; exit;;
*) buildAllComponents; exit;;

esac

}

#-------------------------------- Division --------------------------------#

# Configuration section for build the system

setImageBuildOnLinux(){

export HOST="LINUX"

verifyStaticFiles

startBuildLog

setReleaseBuild

buildHexagonix

}

setImageBuildOnBSD(){

export HOST="BSD"

verifyStaticFiles

startBuildLog

setReleaseBuild

buildHexagonix

}

setImageBuildOnUNIXSolaris()
{

export HOST="UNIX"

verifyStaticFiles

startBuildLog

setReleaseBuild

buildHexagonix

}

prepImagemHexagonixTeste(){

export HOST="LINUX"

verifyStaticFiles

startBuildLog

setTestBuild

buildHexagonix

}

#-------------------------------- Division --------------------------------#

setTestBuild()
{

# Here we will generate a small image, 2 Mb, smaller and just for testing.
# This image should not be used for the installation package.

export DISK_IMAGE_SIZE=2097012
export TEMP_IMAGE_SIZE=2048

}

setReleaseBuild()
{

# Here we will define an official size image, which takes longer to generate.
# This image is appropriate for the Hexagonix installation package

export DISK_IMAGE_SIZE=47185920
export TEMP_IMAGE_SIZE=92160

}

#-------------------------------- Division --------------------------------#

# Section of individual builders of system components

# Here we will separate the common steps for building the system to reuse code
# and make it easier to find errors

buildHexagonKernel(){

cd Hexagon

echo
echo -en "\e[1;94mBuilding the Hexagon kernel...\e[0m"

echo "Building the Hexagon kernel... {" >> ../log.log
echo >> ../log.log

fasm kern/Hexagon.asm Hexagon -d $HEXAGON_FLAGS >> ../log.log || generalBuildError

cp Hexagon ../$DISTRO_DIRECTORY/bin

rm -r Hexagon

echo -e " [\e[32mOk\e[0m]"

echo >> ../log.log
echo "} Hexagon kernel built successfully." >> ../log.log
echo >> ../log.log
echo "----------------------------------------------------------------------" >> ../log.log
echo >> ../log.log

cd ..

}

buildSaturnoBootLoader(){

echo -e "\e[1;94mBuilding Hexagon startup components...\e[0m {"
echo

echo "Building Hexagon startup components... {" >> $LOG
echo >> $LOG

echo -e "\e[1;94m > Hexagon bootloader - Saturno (1st stage)...\e[0m"
echo

echo " > Hexagon bootloader - Saturno (1st stage)..." >> $LOG
echo >> $LOG

cd Boot

cd Saturno

fasm saturno.asm ../saturno.img >> ../../log.log || generalBuildError

echo >> ../../log.log

fasm mbr.asm ../mbr.img >> ../../log.log || generalBuildError

echo >> ../../log.log

cd ..

}

buildHBoot(){

echo -e "\e[1;94mBuilding Hexagon Boot - HBoot (2nd stage)...\e[0m"
echo

echo " > Building Hexagon Boot - HBoot (2nd stage)..." >> ../log.log
echo >> ../log.log

cd "HBoot"

fasm hboot.asm ../hboot -d $HBOOT_FLAGS >> ../../log.log || generalBuildError

cd Mods

if [ -e Spartan.asm ] ; then

for i in *.asm
do

    echo -en "Building HBoot compatible module \e[1;94m$(basename $i .asm).mod\e[0m..."

    echo >> ../../../log.log
    echo " > Building HBoot compatible module $(basename $i .asm).mod..." >> ../../../log.log

    fasm $i ../../`basename $i .asm`.mod -d $COMMON_FLAGS >> ../../../log.log

    echo -e " [\e[32mOk\e[0m]"

done

fi

cd ..

cd ..

cp *.img ../$DISTRO_DIRECTORY
cp hboot ../$DISTRO_DIRECTORY

if [ -e Spartan.mod ] ; then

cp *.mod ../$DISTRO_DIRECTORY/
rm -r *.mod

fi

rm -r *.img
rm -r hboot

echo
echo -e "} [\e[32mStartup components built successfully\e[0m]."

echo >> ../log.log
echo "} Successfully built Hexagon startup components." >> ../log.log
echo >> ../log.log
echo "----------------------------------------------------------------------" >> ../log.log
echo >> ../log.log

cd ..

}

buildUnixUtil(){

# Build Unix base applications

cd Apps/Unix

./Unix.sh $DISTRO_DIRECTORY

cd ..

}

buildAndromedaApplications(){

# Build the Hexagonix-Andromeda applications

cd Andromeda

./Apps.sh $DISTRO_DIRECTORY

cd ..

cd ..

}

buildError()
{

if test $VERBOSE -e 0; then

clear

elif test $VERBOSE -e 1; then

echo

fi

export MSG="System build error"

banner
echo
echo -e "\e[1;31mSomething went wrong while mounting the image:(\e[0m"
echo
echo "Use the system generation script to verify the source of the problem."
echo

umount $PWD/$MOUNT_POINT_DIRECTORY >> /dev/null
umount $DISTRO_DIRECTORY/ >> /dev/null

exit

}

#-------------------------------- Division --------------------------------#

buildAllComponents()
{

export MSG="Building the Hexagonix"

clear

banner

buildSaturnoBootLoader
buildHBoot
buildHexagonKernel
buildUnixUtil
buildAndromedaApplications

finishStep
allDone

}

hexagonixConstructor()
{

export MSG="Building the Hexagonix"

clear

banner

echo "Building the Hexagonix..."
echo

mkdir -p $DISTRO_DIRECTORY
mkdir -p $DISTRO_DIRECTORY/bin
mkdir -p $DISTRO_DIRECTORY/etc

buildSaturnoBootLoader
buildHBoot
buildHexagonKernel
buildUnixUtil
buildAndromedaApplications

echo "Configuring and copying Hexagonix static files... {" >> $LOG
echo >> $LOG

cd Dist

echo "> Copying static configuration files (generated by configure.sh)..." >> ../$LOG

cd etc/

cp rc ../../$DISTRO_DIRECTORY/etc

echo " > rc successfully copied." >> ../../$LOG

cp passwd ../../$DISTRO_DIRECTORY/etc

echo " > passwd successfully copied." >> ../../$LOG

cp host ../../$DISTRO_DIRECTORY/etc

echo " > host configuration file successfully copied." >> ../../$LOG

cp *.unx ../../$DISTRO_DIRECTORY/etc

echo " > *.unx files successfully copied." >> ../../$LOG

cp base.ocl ../../$DISTRO_DIRECTORY/hexgnix.ocl
cp shrc ../../$DISTRO_DIRECTORY/etc

echo " > Hexagonix version files successfully copied." >> ../../$LOG

cd ..

echo "> Copying Hexagonix utility manuals..." >> ../$LOG

cd man

cp *.man ../../$DISTRO_DIRECTORY

cd ..
cd ..

cd Fonts/

echo "> Checking for additional fonts to build..." >> ../$LOG

if [ -e aurora.asm ] ; then

echo -e "There are graphic fonts to be built and copied... [\e[32mOk\e[0m]"
echo " > There are graphic fonts to be built and copied..." >> ../$LOG

./fonts.sh

cp *.fnt ../$DISTRO_DIRECTORY
rm *.fnt

echo
echo -n "Fonts copied"
echo -e " [\e[32mOk\e[0m]"
echo " > Fonts copied." >> ../$LOG
echo

else

echo " > There are no graphic fonts to be built and copied..." >> ../$LOG
echo -e "There are no graphic fonts to build and copy... [\e[32mOk\e[0m]"
echo

fi

# Let's also copy the header file to be able to develop on Hexagonix

cd ..

echo "> Copying core development libraries..." >> $LOG
echo "Copying core development libraries..."
echo

cd lib/fasm

cp hexagon.s ../../$DISTRO_DIRECTORY
cp console.s ../../$DISTRO_DIRECTORY
cp macros.s ../../$DISTRO_DIRECTORY

cd Estelar

cp estelar.s ../../../$DISTRO_DIRECTORY

cd ..
cd ..

cd samples

cp * ../../$DISTRO_DIRECTORY/

cd ..
cd ..

echo -n "Libraries copied"
echo -e " [\e[32mOk\e[0m]"
echo

echo >> $LOG
echo "} Success configuring and copying Hexagonix configuration files." >> $LOG
echo >> $LOG
echo "----------------------------------------------------------------------" >> $LOG
echo >> $LOG

echo "Building additional (contrib) packages... {" >> $LOG
echo >> $LOG

if [ -e Contrib/Contrib.sh ] ; then

echo "> There are additional packages to build." >> $LOG
echo >> $LOG

cd Contrib

./Contrib.sh $DISTRO_DIRECTORY

cd ..

else

echo "> There are no additional packages to build." >> $LOG
echo "There are no additional packages to build."
echo

fi

echo >> $LOG
echo "} Success processing additional (contrib) packages." >> $LOG
echo
echo "> View the 'log.log' log file for more information of the build."
echo

}

generalBuildError(){

echo "An error occurred while building some system component."
echo
echo "Check the status of the components and use the above error outputs to verify the problem."
echo
echo "View the log file 'log.log', for more information about the error(s)."
echo

umount $MOUNT_POINT_DIRECTORY/ >> /dev/null
umount $DISTRO_DIRECTORY/ >> /dev/null

exit

}

#-------------------------------- Division --------------------------------#

# System image build section

buildHexagonix()
{

if test "`whoami`" != "root" ; then

sureq

exit

fi

# Now the system files will be generated...

hexagonixConstructor

# Now the system image will be prepared...

echo -e "\e[1;94mBuilding system image...\e[0m"
echo

echo >> $LOG
echo "----------------------------------------------------------------------" >> $LOG
echo >> $LOG
echo "Build a Hexagonix disk image... {" >> $LOG
echo >> $LOG
echo "> Building temporary image for file manipulation..." >> $LOG

# Now let's check which system is the host, to adapt the disk image creation logic for each one.
# Supported so far: Linux and FreeBSD (FreeBSD in development)

if [ "$HOST" == "LINUX" ]; then

buildImageOnLinux

fi

if [ "$HOST" == "BSD" ]; then

buildImageOnBSD

fi

# From now on, the logic is the same for all supported host systems

echo "> Copying system files to the image..." >> $LOG
echo >> $LOG

cp $DISTRO_DIRECTORY/*.man $MOUNT_POINT_DIRECTORY/ >> $LOG || buildError
cp $DISTRO_DIRECTORY/*.asm $MOUNT_POINT_DIRECTORY/ >> $LOG
cp $DISTRO_DIRECTORY/*.s $MOUNT_POINT_DIRECTORY/ >> $LOG
cp $DISTRO_DIRECTORY/*.cow $MOUNT_POINT_DIRECTORY/ >> $LOG || buildError
cp $DISTRO_DIRECTORY/bin/* $MOUNT_POINT_DIRECTORY/ >> $LOG || buildError
cp $DISTRO_DIRECTORY/hboot $MOUNT_POINT_DIRECTORY/ >> $LOG || buildError

# License must be copied

cp Dist/man/LICENSE $MOUNT_POINT_DIRECTORY/ >> $LOG || buildError

# Now copy HBoot modules

if [ -e $DISTRO_DIRECTORY/Spartan.mod ] ; then

cp $DISTRO_DIRECTORY/*.mod $MOUNT_POINT_DIRECTORY/ >> $LOG

fi

cp $DISTRO_DIRECTORY/etc/* $MOUNT_POINT_DIRECTORY/>> $LOG || buildError
cp $DISTRO_DIRECTORY/*.ocl $MOUNT_POINT_DIRECTORY/ >> $LOG || buildError

# If the image should contain a copy of the FreeDOS files for testing...

if [ -e DOS ] ; then

cp DOS/*.* $MOUNT_POINT_DIRECTORY/

fi

# Now it will be checked whether any font should be included in the image
#
# If the default font file is available, use this information as a switch to 
# turn on the copy

echo -n "> Checking if there are graphic fonts to copy..." >> $LOG

if [ -e $DISTRO_DIRECTORY/aurora.fnt ] ; then

echo " [Yes]" >> $LOG

cp $DISTRO_DIRECTORY/*.fnt $MOUNT_POINT_DIRECTORY/ || buildError

fi

if [ ! -e $DISTRO_DIRECTORY/aurora.fnt ] ; then

echo " [No]" >> $LOG

fi

verifyContribPackages

echo >> $LOG

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

dd status=none conv=notrunc if=$DISTRO_DIRECTORY/mbr.img of=$IMAGE_FILENAME >> $LOG || buildError

echo "> Removing temporary files and folders, as well as binaries that are no longer needed..." >> $LOG
echo >> $LOG

rm -rf $MOUNT_POINT_DIRECTORY $DISTRO_DIRECTORY temp.img >> $LOG

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

echo >> $LOG
echo "} Hexagonix disk images built successfully." >> $LOG
echo >> $LOG

export MSG="Build the Hexagonix"

banner

infoBuild

showCreateInstallerInfo

finishBuildLog

mv log.log $IMAGE_PATH/log.log
chown $IMAGE_PATH/log.log --reference=$IMAGE_PATH/README.md

exit

}

#-------------------------------- Division --------------------------------#

# Specific disk image generation code for Linux

buildImageOnLinux()
{

dd status=none bs=512 count=$TEMP_IMAGE_SIZE if=/dev/zero of=temp.img >> $LOG || buildError

if [ ! -e hexagonix.img ] ; then

echo >> $LOG
echo "> Building image that will receive system files..." >> $LOG
echo >> $LOG

dd status=none bs=$DISK_IMAGE_SIZE count=1 if=/dev/zero of=$IMAGE_FILENAME >> $LOG || buildError

fi

echo "> Copying bootloader (Saturno) to image..." >> $LOG

dd status=none conv=notrunc if=$DISTRO_DIRECTORY/saturno.img of=temp.img >> $LOG || buildError

echo "> Mounting the image..." >> $LOG

mkdir -p $MOUNT_POINT_DIRECTORY && mount -o loop -t vfat temp.img $MOUNT_POINT_DIRECTORY/ || buildError

}

# Specific disk image generation code for Solaris (OpenIndiana, illumos and derivatives)

buildImageOnUNIXSolaris()
{

dd status=none bs=512 count=$TEMP_IMAGE_SIZE if=/dev/zero of=temp.img >> $LOG || buildError

if [ ! -e hexagonix.img ] ; then

echo >> $LOG
echo "> Building image that will receive system files..." >> $LOG
echo >> $LOG

dd status=none bs=$DISK_IMAGE_SIZE count=1 if=/dev/zero of=$IMAGE_FILENAME >> $LOG || buildError

fi

echo "> Copying bootloader (Saturno) to image..." >> $LOG

dd status=none conv=notrunc if=$DISTRO_DIRECTORY/saturno.img of=temp.img >> $LOG || buildError

echo "> Mounting the image..." >> $LOG

lofiadm -a temp.img

mkdir -p $MOUNT_POINT_DIRECTORY && mount -F lofs /dev/lofi/1 $MOUNT_POINT_DIRECTORY/ || buildError

}

# Specific disk image generation code for FreeBSD

buildImageOnBSD()
{

# Reserved sectors = 16
# Fats = 2
# Root entries = 512
# Sectors per fat = 16
# Sectores per track = 63
# Heads = 255
# Hidden sectores = 0
# Total sectors = 92160

newfs_msdos -C 45m -F 16 -B $DISTRO_DIRECTORY/saturno.img temp.img

if [ ! -e hexagonix.img ] ; then

echo "> Building image that will receive system files..."

newfs_msdos -C 90m -F 16 hexagonix.img

fi

mdconfig -a -t vnode -f temp.img -o force -u 4

echo "> Mounting the image..." >> $LOG

mkdir -p $MOUNT_POINT_DIRECTORY && mount_msdosfs /dev/md4 $MOUNT_POINT_DIRECTORY/ || buildError

}

#-------------------------------- Division --------------------------------#

verifyContribPackages()
{

# Check if there are additional files to be added to the image.
# These files must be in the contrib directory.

if [ -e contrib/ ] ; then

cp contrib/* $MOUNT_POINT_DIRECTORY/

fi

}

#-------------------------------- Division --------------------------------#

# hx virtual machine management section

manageVirtualMachines()
{

case $PT2 in

hx) vmHexagonixWithKVM; exit;;
hx.bsd) vmHexagonixOnBSDHost; exit;;
hx.wsnd) vmHexagonixWithoutSnd; exit;;
hx.serial) vmHexagonixWithoutSerialRedirection; exit;;
hx.p3) vmHexagonixPentium3; exit;;
*) vmHexagonixWithKVM; exit;; # Assume hx -v hx

esac

}

vmHexagonixPentium3()
{

export QEMU_ARGS="--enable-kvm -serial file:Serial.txt -cpu $PROCESSOR -hda $DISK_IMAGE_PATH -m $MEMORY -audiodev $AUDIODEV -k pt-br"
export NOTA="Using KVM and legacy processor (Pentium III)"

startVirtualMachine

}

vmHexagonixWithoutSnd()
{

export QEMU_ARGS="--enable-kvm -serial file:Serial.txt -cpu host -hda $DISK_IMAGE_PATH -m $MEMORY -k pt-br"
export NOTA="Using without sound device"

startVirtualMachine

}

vmHexagonixOnBSDHost()
{

export QEMU_ARGS="-cpu $PROCESSOR -hda $DISK_IMAGE_PATH -m $MEMORY -k pt-br"
export NOTA="BSD mode"

startVirtualMachine

}

vmHexagonixWithKVM()
{


export QEMU_ARGS="--enable-kvm -serial file:Serial.txt -cpu host -hda $DISK_IMAGE_PATH -m $MEMORY -audiodev $AUDIODEV -k pt-br"
export NOTA="Using KVM and serial output to file"

startVirtualMachine

}

vmHexagonixWithoutSerialRedirection()
{

export QEMU_ARGS="-serial stdio -hda $DISK_IMAGE_PATH -cpu $PROCESSOR -m $MEMORY -k pt-br"
export NOTA="Using serial output to console"

startVirtualMachine

}

startVirtualMachine()
{

if [ -e $DISK_IMAGE_PATH ] ; then

clear

export MSG="hx: start virtual machine"

banner

echo
echo -e "\e[1mStarting virtual machine with the following specifications:\e[0m"
echo
echo -e "> Image target architecture: \e[1;32m$SYSTEM_ARCH\e[0m"
echo -e "> Note: \e[1;32m$NOTA\e[0m"
echo -e "> Disk image: \e[1;32m$DISK_IMAGE_PATH\e[0m"
echo -e "> Output sound: \e[1;32m$DRV_SOUND\e[0m"
echo -e "> Memory: \e[1;32m$MEMORY megabytes\e[0m; processor: \e[1;32m$PROCESSOR\e[0m"
echo

qemu-system-$SYSTEM_ARCH $QEMU_ARGS -D /dev/null >> /dev/null || virtualMachineGeneralError

else

virtualMachineGeneralError

fi

}

virtualMachineGeneralError()
{

clear

export MSG="hx: start virtual machine"

banner

echo -e "Error in request: disk image \e[1;94m'$DISK_IMAGE_PATH'\e[0m not found or fail"
echo -e "\e[0min some virtual machine component or parameter."
echo -e " > \e[1;31mYou CANNOT boot the system without this error.\e[0m"
echo -e "Error in request: \e[1;94mproblem while running virtual machine\e[0m."
echo -e " > \e[1;31mTry running the virtual machine again\e[0m."
echo

}

#-------------------------------- Division --------------------------------#

# hx utilities section

cleanObjectsInSourceTree()
{

clear

export MSG="hx: clear system tree"

banner

echo "Performing system tree cleanup..."
echo -n " > Cleaning up generated components and system images..."

rm -rf $MOUNT_POINT_DIRECTORY $DISTRO_DIRECTORY Hexagonix temp.img hexagonix.img
rm -rf log.log COM1.txt *.sis *.bin *.app Serial.txt

echo -e " [\e[32mOk\e[0m]"
echo -e "   > \e[1;94mUse ./hx with parameters to regenerate these files.\e[0m"
echo -e "   > For help on possible parameters, use ./hx -h."
echo -n " > Removing configuration files generated every build..."

rm -rf Dist/etc/*.unx Dist/etc/*.ocl Dist/etc/rc Dist/etc/passwd Dist/etc/shrc Dist/etc/host

echo -e " [\e[32mOk\e[0m]"
echo -e "   > \e[1;94mUse ./configure.sh to regenerate these files.\e[0m"

allDone

echo

}

getBuildInformation()
{

# Hexagonix version data

export REVISAO=$(cat Dist/etc/release.def)
export CODENOME=$(cat Dist/etc/codenome.def)
export VERSAO=$(cat Dist/etc/versao.def)

}

infoBuild()
{

clear

export MSG="System information"

banner

echo -e "Information about the \e[1mcurrent\e[0m build of the system:"
echo -e " > Hexagonix version: \e[1;32m$VERSAO\e[0m"
echo -e " > Software revision: \e[1;32m$REVISAO\e[0m"
echo -e " > Release name: \e[1;32m$CODENOME\e[0m"
echo -e " > Disk image location: \e[1;32m$IMAGE_PATH/$IMAGE_FILENAME\e[0m"
echo

}

startIndentModule()
{

clear

if [ -e Scripts/indent.sh ] ; then

cp Scripts/indent.sh .

echo
echo -e "[\e[32mAllowing execution and starting indent.sh (using '-a' parameter)...\e[0m]"

# First, make sure the file can be executed

chmod +x indent.sh

./indent.sh -a

rm indent.sh

else

echo -e "[\e[31mError: indent.sh not found\e[0m]."

fi

finishStep
allDone

}

startConfigureModule()
{

clear

if [ -e configure.sh ] ; then

echo
echo -e "[\e[32mAllowing execution and starting configure.sh...\e[0m]"

# First, make sure the file can be executed

chmod +x configure.sh

./configure.sh

else

echo -e "[\e[31mError: configure.sh not found\e[0m]"
echo -e " > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

finishStep
allDone

}

finishStep()
{

echo -e "[\e[32mStep completed successfully\e[0m]"

}

allDone()
{

echo -e "[\e[32mAll ready!\e[0m]"

}

verifyStaticFiles()
{

# Let's check if the essential static files have already been generated before.
# If not, we will generate them

if [ -e Dist/etc/base.ocl ] ; then

echo "Static files present."

else

clear

export MSG="Building the Hexagonix"

banner

echo "The static files needed to build the system were not found."
echo "Build could not be started. To do so, hx will run ./configure.sh"
echo "to set up the build and generate the necessary files."
echo
echo "Press <ENTER> to continue or CTRL-C to cancel..."

read resposta

./configure.sh

fi

}

displayStatistics(){

clear

export MSG="Statistics"

banner

if [ -e /usr/bin/cloc ] ; then

for i in */
do

    echo
    echo -en "\e[1;94mStats of the directory $i:\e[0m"
    echo
    echo

    cloc $i

    finishStep

done

    echo
    echo -en "\e[1;94mSystem global statistics:\e[0m"
    echo
    echo

    cloc $(pwd)

    finishStep

allDone

else

echo
echo -e "[\e[1;31mCloc utility not found.\e[0m]"
echo -e "\e[1;94mhx cannot report statistics without this dependency.\e[0m"

fi

echo

}

showBuildFlags()
{

clear

export MSG="Hexagonix build flags"

banner

echo "Common flags:"
echo -e " > \e[1;32m$COMMON_FLAGS\e[0m"
echo "Hexagon flags:"
echo -e " > \e[1;32m$HEXAGON_FLAGS\e[0m"
echo "HBoot build flags:"
echo -e " > \e[1;32m$HBOOT_FLAGS\e[0m"
echo

allDone
finishStep

}

startBuildLog()
{

if [ -e $LOG ] ; then

rm -r $LOG

fi

# Create the log file header

echo "Hexagonix Operating System build and statistics report" >> $LOG
echo "-------------------------------------------------------" >> $LOG
echo >> $LOG
echo "Hexagonix Operating System" >> $LOG
echo "Copyright (c) 2015-2024 Felipe Miguel Nery Lunkes. All rights reserved." >> $LOG
echo >> $LOG
echo "Hexagonix is licenced under BSD-3-Clause and comes with no warranty." >> $LOG
echo >> $LOG
echo "-------------------------------------------------------" >> $LOG
echo >> $LOG
echo "In this file, you have access to the complete log of the build process of" >> $LOG
echo "Hexagonix components. You can also use it to identify the environment used in" >> $LOG
echo "build, as well as errors found in the process." >> $LOG
echo >> $LOG
echo "hx version: $HX_VERSION" >> $LOG
echo >> $LOG
echo "Build task id: $BUILD_ID" >> $LOG
echo >> $LOG
echo "Information about the current build of Hexagonix:" >> $LOG
echo " > Hexagonix version: $VERSAO" >> $LOG
echo " > Software revision: $REVISAO" >> $LOG
echo " > Release name: $CODENOME" >> $LOG
echo " > Disk image location: $IMAGE_PATH/$IMAGE_FILENAME" >> $LOG
echo " > Main system branch (git): $MAIN_BRANCH" >> $LOG
echo "   > Andromeda-Apps branch: $ANDROMEDA_APPS_BRANCH" >> $LOG
echo "   > Unix-Apps branch: $UNIX_APPS_BRANCH" >> $LOG
echo "   > HBoot branch: $HBOOT_BRANCH" >> $LOG
echo "   > Saturno branch: $SATURNO_BRANCH" >> $LOG
echo "   > etc branch: $ETC_BRANCH" >> $LOG
echo "   > man branch: $MAN_BRANCH" >> $LOG
echo "   > Fonts branch: $FONT_BRANCH" >> $LOG
echo "   > Hexagon branch: $HEXAGON_BRANCH" >> $LOG
echo "   > libasm branch: $LIBASM_BRANCH" >> $LOG
echo "   > hx/Scripts branch: $HX_BRANCH" >> $LOG
echo " > Server: $SERVER" >> $LOG
echo >> $LOG
echo "Information about the current build environment:" >> $LOG
echo -n " > Date and time of this report (build time): " >> $LOG
date >> $LOG
echo -n " > User logged in: " >> $LOG
whoami >> $LOG
echo -n " > Operating system version: " >> $LOG
uname -srmpi >> $LOG
echo -n " > fasm version: " >> $LOG
fasm | grep "flat" >> $LOG
echo -n " > GNU bash version: " >> $LOG
bash --version | grep "GNU bash" >> $LOG

# Let's now check the version of optional tools such as qemu, NASM and vscode

if [ -e /usr/bin/qemu-system-i386 ] ; then

echo -n " > qemu version: " >> $LOG
qemu-system-i386 --version | grep "QEMU emulator" >> $LOG

fi

if [ -e /usr/bin/nasm ] ; then

echo -n " > nasm version: " >> $LOG
nasm --version >> $LOG

fi

if [ -e /usr/bin/VirtualBox ] ; then

echo -n " > VirtualBox version: " >> $LOG
vboxmanage --version >> $LOG

fi

if [ -e /usr/bin/code ] ; then

echo -n " > vscode version: " >> $LOG
code --version --no-sandbox --user-data-dir /dev/null | head -n 1 >> $LOG

fi

echo >> $LOG
echo " > Build flags:" >> $LOG
echo "   > HBoot build flags: $HBOOT_FLAGS" >> $LOG
echo "   > Hexagon build flags: $HEXAGON_FLAGS" >> $LOG
echo "   > Common userland build flags: $COMMON_FLAGS" >> $LOG

echo >> $LOG
echo "----------------------------------------------------------------------" >> $LOG
echo >> $LOG

}

showCreateInstallerInfo()
{

echo "> Disk image '$IMAGE_FILENAME' and VM disk image '$(basename $IMAGE_FILENAME .img).vdi' generated successfully." >> $LOG
echo >> $LOG
echo "Use './hx -v hx' to test running the system on the generated image or copy" >> $LOG
echo "the image to the installer 'Inst' directory to generate an Linux-based install" >> $LOG
echo "image for transfer to physical disk." >> $LOG
echo >> $LOG
echo "----------------------------------------------------------------------" >> $LOG
echo >> $LOG

}

finishBuildLog()
{

echo -n "End date/time of this log: " >> $LOG
date >> $LOG
echo >> $LOG
echo "----------------------------------------------------------------------" >> $LOG
echo >> $LOG

}

installBuildDependencies()
{

if test "`whoami`" != "root" ; then

sureq

exit

fi

export MSG="Install dependencies"

banner

echo
echo -e "hx will now install the necessary dependencies to run it:"
echo

apt install fasm nasm cloc qemu qemu-system-i386 uuid

finishStep

echo
echo -e "\e[1mReady! Now run \e[32m./configure.sh\e[0;1m to configure the dependencies."

allDone

echo

}

banner()
{

echo -e "******************************************************************************"
echo
echo -e " ┌┐ ┌┐                              \e[1;94mHexagonix Operating System\e[0m"
echo -e " ││ ││"
echo -e " │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright (c) 2015-2024 Felipe Miguel Nery Lunkes\e[0m"
echo -e " │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘             \e[1;94mAll rights reserved.\e[0m"
echo -e " ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐"
echo -e " └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘"
echo -e "              ┌─┘│                       \e[1;32m$MSG\e[0m"
echo -e "              └──┘"
echo
echo -e "******************************************************************************"
echo

}

updateDiskImages()
{

export MSG="Update images"

banner

echo "You are about to update the Hexagonix disk images by synchronizing them"
echo "with those available in the image repository, in the main (stable) branch."
echo -e "\e[1;31mWarning! This process will destroy any modifications within the local images!\e[0m"
echo
echo
echo -n "Do you want to continue [y/N] (press ENTER after selection): "

read OPCAO

case $OPCAO in

y) updateAuthorized; exit;;
Y) updateAuthorized; exit;;
n) finish; exit;;
N) finish; exit;;
*) finish; exit;;

esac

}

updateAuthorized()
{

cd hexagonix

rm -rf hexagonix.img hexagonix.vdi

wget https://github.com/hexagonix/hexagonix/blob/main/hexagonix.img
wget https://github.com/hexagonix/hexagonix/blob/main/hexagonix.vdi

finishStep
allDone

}

infoRepo()
{

export MSG="Repos information"

echo
echo "hx version $HX_VERSION"
echo
echo -e " > Currently, you are using this configuration for the repositories:"
echo -e "   > Main system branch (git): \e[1;32m$MAIN_BRANCH\e[0m"
echo -e "   > Andromeda-Apps branch: \e[1;32m$ANDROMEDA_APPS_BRANCH\e[0m"
echo -e "   > Unix-Apps branch: \e[1;32m$UNIX_APPS_BRANCH\e[0m"
echo -e "   > HBoot branch: \e[1;32m$HBOOT_BRANCH\e[0m"
echo -e "   > Saturno branch: \e[1;32m$SATURNO_BRANCH\e[0m"
echo -e "   > etc branch: \e[1;32m$ETC_BRANCH\e[0m"
echo -e "   > man branch: \e[1;32m$MAN_BRANCH\e[0m"
echo -e "   > Fonts branch: \e[1;32m$FONT_BRANCH\e[0m"
echo -e "   > Hexagon branch: \e[1;32m$HEXAGON_BRANCH\e[0m"
echo -e "   > libasm branch: \e[1;32m$LIBASM_BRANCH\e[0m"
echo -e "   > hx/Scripts branch: \e[1;32m$HX_BRANCH\e[0m"
echo -e " > Server: \e[1;94m$SERVER\e[0m"
echo

finishStep
allDone

}

updateRepositories()
{

export MSG="Update repos"

banner

echo "You are about to update all repositories with the server, keeping current"
echo "branch. To change branch and update, use hx -un <branch>."
echo
echo "Update info:"
echo -e " > Branch: \e[1;94m$MAIN_BRANCH\e[0m"
echo -e " > Server: \e[1;94mhttps://github.com/hexagonix\e[0m"
echo
echo -e "> \e[1;32mUpdating repositories...\e[0m"
echo

cd Apps/Unix && git pull
cd ..
cd Andromeda && git pull
cd ..
cd ..
cd Boot/Saturno && git pull
cd ..
cd "HBoot" && git pull
cd ..
cd ..
cd Dist/etc && git pull
cd ..
cd man && git pull
cd ..
cd ..
cd Doc && git pull
cd ..
cd Contrib/fasmX && git pull
cd ..
cd ..
cd Fonts && git pull
cd ..
cd Hexagon && git pull
cd ..
cd hexagonix && git pull
cd ..
cd lib && git pull
cd ..
cd Scripts && git pull

echo
echo -e "> \e[1;32mUpdating building scripts and utilities...\e[0m"
echo

cp hx configure.sh ../
cp Contrib.sh ../Contrib/

cd ..

chmod +x configure.sh hx Contrib/Contrib.sh

if [ -e autohx.py ] ; then

# autohx is present and must be updated

cd autohx && git pull

cp autohx.py ../

cd ..

chmod +x autohx.py

fi

finishStep
allDone

}

switchBranchAndUpdateRepositories()
{

export MSG="Update branch and repositories"

banner

echo "You are about to update all system repositories with the server,"
echo "after switching to the given branch."
echo
echo "Update info:"
echo -e " > Branch: \e[1;94m$PT2\e[0m"
echo -e " > Server: \e[1;94mhttps://github.com/hexagonix\e[0m"
echo
echo -e "> \e[1;32mUpdating repositories...\e[0m"
echo

cd Apps/Unix && git switch $PT2 && git pull
cd ..
cd Andromeda && git switch $PT2 && git pull
cd ..
cd ..
cd Boot/Saturno && git switch $PT2 && git pull
cd ..
cd "HBoot" && git switch $PT2 && git pull
cd ..
cd ..
cd Dist/etc && git switch $PT2 && git pull
cd ..
cd man && git switch $PT2 && git pull
cd ..
cd ..
cd Doc && git switch $PT2 && git pull
cd ..
cd Contrib/fasmX && git switch $PT2 && git pull
cd ..
cd ..
cd Fonts && git switch $PT2 && git pull
cd ..
cd Hexagon && git switch $PT2 && git pull
cd ..
cd hexagonix && git switch $PT2 && git pull
cd ..
cd lib && git switch $PT2 && git pull
cd ..
cd Scripts && git switch $PT2 && git pull

echo
echo -e "> \e[1;32mUpdating building scripts and utilities...\e[0m"
echo

cp hx configure.sh ../
cp Contrib.sh ../Contrib/
cd ..

chmod +x configure.sh hx Contrib/Contrib.sh

if [ -e autohx.py ] ; then

# autohx is present and must be updated

cd autohx && git pull

cp autohx.py ../

cd ..

chmod +x autohx.py

fi

finishStep
allDone

}

cloneRepositories()
{

clear

export MSG="Build the Hexagonix"

banner

echo "Cloning the repositories needed to build Hexagonix..."
echo

# First, let's create the common directories

cd Hexagonix

mkdir -p Apps/
mkdir -p Boot/
mkdir -p Contrib/
mkdir -p Dist/

# Let's clone Hexagon

git clone https://github.com/hexagonix/Hexagon Hexagon

# Let's clone Saturno and HBoot

git clone https://github.com/hexagonix/Saturno Boot/Saturno
git clone https://github.com/hexagonix/HBoot "Boot/HBoot"

# Let's now clone the utility repositories

git clone https://github.com/hexagonix/Unix-Apps Apps/Unix
git clone https://github.com/hexagonix/Andromeda-Apps Apps/Andromeda

# Let's clone the libraries

git clone https://github.com/hexagonix/lib lib

# Now let's upload static and manual files

git clone https://github.com/hexagonix/man Dist/man
git clone https://github.com/hexagonix/etc Dist/etc

# Let's clone the graphic fonts

git clone https://github.com/hexagonix/xfnt Fonts

# Now fasmX

git clone https://github.com/hexagonix/fasmX Contrib/fasmX

# Now the image repository

git clone https://github.com/hexagonix/hexagonix hexagonix

# Now the documentation

git clone https://github.com/hexagonix/Doc

# Lastly, the system generation scripts

git clone https://github.com/hexagonix/scriptsHX Scripts

# Now the autohx utility

git clone https://github.com/felipenlunkes/hexagonix-autobuild autohx

# Now let's put things in place

cd Scripts

cp configure.sh hx ../
cp Contrib.sh ../Contrib

cd ..

cd autohx

cp autohx.py ../

cd ..

chmod +x configure.sh hx autohx.py

echo
echo -e "[\e[32mAll ready!\e[0m]"
echo

exit

}

checkCloneDependencies()
{

clear

export MSG="Build the Hexagonix"

banner

echo -e "Checking required dependencies to clone the repositories..."
echo

# Now let's check each build engine dependency

# Dependency 1

echo -n " > git "

if [ -e /usr/bin/git ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start without this dependency\e[0m."

exit

fi

cloneRepositories

}

finish()
{

exit

}

sureq()
{

clear

export MSG="hx: you need to be root"

banner

echo -e "\e[1;94mYou must be a root user to perform the requested action ;D\e[0m"
echo
echo -e "\e[1;32mEnter your password below to change to the root user (root) an run hx again with\e[0m"
echo -e "\e[1;32mgiven parameters.\e[0m"
echo

sudo hx $PT1 $PT2 $PT3 $PT4 $PT5

exit

}

#-------------------------------- Division --------------------------------#

#;;************************************************************************************

# Hx entry point, variable definition and parameter processing
#
#
# Copyright (c) 2015-2024 Felipe Miguel Nery Lunkes
# All rights reserved
# Constants with parameter parsing

export PT1=$1
export PT2=$2
export PT3=$3
export PT4=$4
export PT5=$5
export PT6=$6

# hx info

export HX_NAME=$0
export HX_VERSION="13.17.2"

# Variables and constants used in build and QEMU

# Constants for virtual machine execution (QEMU)

export DRV_SOUND="pcspk"
export SYSTEM_ARCH="i386"
export BSD_SYSTEM_ARCH="x86_64"
export PROCESSOR="pentium3"
export MEMORY=32
export AUDIODEV="pa,id=audio0 -machine pcspk-audiodev=audio0"

# Build step constants

export LOG="log.log"
export SERVER="https://github.com/hexagonix"
export BUILD_ID=$(uuid -m -v 4)

# Constants for the system build and image creation steps.
# These are the default flags, and can be changed by parameters to
# change the behavior of the Hexagonix build or components

export DISK_IMAGE_PATH="hexagonix/hexagonix.img" # Image filename with relative path
export IMAGE_PATH="hexagonix" # Image path
export COMMON_FLAGS="VERBOSE=YES -d LOGIN_STYLE=Hexagonix" # General build flags
export HEXAGON_FLAGS="VERBOSE=YES" # Hexagon build flags
export HBOOT_FLAGS="SOUND_THEME=Hexagonix" # HBoot build flags
export DISTRO_DIRECTORY="Build" # Location of executable images and generated static files
export IMAGE_FILENAME="hexagonix.img" # Final image name (without directory)
export MOUNT_POINT_DIRECTORY="SystemBuild" # Disk image mount point for copying Hexagonix files

# Now, let's define where the libasm headers and libraries (necessary for fasm) are

export INCLUDE="$(pwd)/lib/fasm"

# Get information from the branch used to build the system
#
# Notice! The information is obtained from the github.com/hexagonix/hexagonix repository only.
# It is not recommended to build the system using different branches, but to use all components
# coming from the same branch, such as CURRENT (main) or RELEASE.
# Mixing between the branches can cause various components to not work or work incorrectly.
# To sync all repositories with the same branch, use 'hx -un branch'.

if [ -e $DISK_IMAGE_PATH ] ; then

# Let's save each branch of the system components for later identification

# First, Andromeda-Apps and Unix-Apps
cd Apps/Andromeda
export ANDROMEDA_APPS_BRANCH=$(git branch --show-current)
cd ../Unix
export UNIX_APPS_BRANCH=$(git branch --show-current)
cd ../..
# Now HBoot and Saturno
cd "Boot/HBoot"
export HBOOT_BRANCH=$(git branch --show-current)
cd ../Saturno
export SATURNO_BRANCH=$(git branch --show-current)
cd ../..
cd Dist/etc
export ETC_BRANCH=$(git branch --show-current)
cd ../man
export MAN_BRANCH=$(git branch --show-current)
cd ../..
# Now fonts
cd Fonts
export FONT_BRANCH=$(git branch --show-current)
cd ..
# Now Hexagon
cd Hexagon
export HEXAGON_BRANCH=$(git branch --show-current)
cd ..
# Now libasm
cd lib
export LIBASM_BRANCH=$(git branch --show-current)
cd ..
# Now hx and hx modules
cd Scripts
export HX_BRANCH=$(git branch --show-current)
cd ..
# Main branch of everything, where the images will go
cd hexagonix
export MAIN_BRANCH=$(git branch --show-current)
cd ..

fi

# Perform the action determined by the given parameter

case $1 in

# Manage parameters starting with '-'

-v) manageVirtualMachines; exit;;
-i) manageBuild; exit;;
-h) showMainHelp; exit;;
-b) manageComponentConstruction; exit;;
-br) infoRepo; exit;;
-u) updateRepositories; exit;;
-ui) updateDiskImages; exit;;
-un) switchBranchAndUpdateRepositories; exit;;
-m) checkCloneDependencies; exit;;
-c) cleanObjectsInSourceTree; exit;;

# Manage parameters starting with '--'

--version) showVersion; exit;;
--depend) installBuildDependencies; exit;;
--info) getBuildInformation; infoBuild; exit;;
--configure) startConfigureModule; exit;;
--indent) startIndentModule; exit;;
--stat) displayStatistics; exit;;
--flags) showBuildFlags; exit;;

# Default function

*) parametersRequired; exit;;

esac
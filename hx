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

function main() {

# Let's configure the environment and start argument parsing

setupEnvironment

# Allow execution of any hx module

chmod +x $MOD_DIR/*.hx

# Perform the action determined by the given parameter

case $1 in

# Manage parameters starting with '-'

-v) manageVirtualMachines; exit;;
-i) manageBuild; exit;;
-h) showMainHelp; exit;;
-b) manageComponentBuild; exit;;
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

}

function setupEnvironment() {

# Let's configure environment and export constants

# Build step constants

export REMOTE="https://github.com/hexagonix"
export BUILD_ID=$(uuid -m -v 4)
export LOG="$(pwd)/log.log"

# Global configuration

# Constants for the system build and image creation steps.
# These are the default flags, and can be changed by parameters to change the behavior of
# the Hexagonix build or components.
# These variables MUST be exported. They must be accessible to child shell instances

export DISK_IMAGE_PATH="hexagonix/hexagonix.img" # Image filename with relative path
export IMAGE_PATH="hexagonix" # Image path
export COMMON_FLAGS="VERBOSE=YES -d LOGIN_STYLE=Hexagonix" # General build flags
export HEXAGON_FLAGS="VERBOSE=YES" # Hexagon build flags
export HBOOT_FLAGS="SOUND_THEME=Hexagonix" # HBoot build flags
export BUILD_DIRECTORY="$(pwd)/Build" # Location of executable images and generated static files
export IMAGE_FILENAME="hexagonix.img" # Final image name (without directory)
export MOUNT_POINT_DIRECTORY="$(pwd)/SystemBuild" # Disk image mount point for copying Hexagonix files
export ROOT_DIR="$(pwd)"

# Convert from command line to assembler for readable flags by removing parameters such as '-d'

export CONDENSED_HBOOT_FLAGS=$(tr ' ' '\n' <<< "$HBOOT_FLAGS" | grep -vf <(tr ' ' '\n' <<< "-d") | paste -sd ' ')
export CONDENSED_HEXAGON_FLAGS=$(tr ' ' '\n' <<< "$HEXAGON_FLAGS" | grep -vf <(tr ' ' '\n' <<< "-d") | paste -sd ' ')
export CONDENSED_COMMON_FLAGS=$(tr ' ' '\n' <<< "$COMMON_FLAGS" | grep -vf <(tr ' ' '\n' <<< "-d") | paste -sd ' ')

# Now, let's define where the libasm headers and libraries (necessary for fasm) are
# The variable MUST be exported. It needs to be accessible to child shell instances

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

}

#-------------------------------- Division --------------------------------#

# Help section and information about hx

function showMainHelp() {

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

function showVirtualMachineHelp() {

echo
echo "hx $HX_VERSION help topics: running Hexagonix with virtual machone (qemu)"
echo
echo -e "Start a Hexagonix virtual machine. The available parameters are\e[1;31m (default hx)*\e[0m:"
echo -e "\e[1;32m hx\e[0m        - Start virtual machine without sound"
echo -e "\e[1;32m hx.snd\e[0m    - Start virtual machine with sound"
echo -e "\e[1;32m hx.serial\e[0m - Start virtual machine with no serial output"
echo -e "\e[1;32m hx.p3\e[0m     - Start virtual machine with a legacy processor (Pentium III)"
echo -e "\e[1;32m hx.bsd\e[0m    - Start BSD host compatible virtual machine"
echo -e "\e[1;31m* The 'hx' option will be selected if no parameter is passed after '-v'!\e[0m"

}

function showBuildHelp() {

echo
echo "hx $HX_VERSION help topics: building system disk"
echo
echo -e "Build disk image. The available parameters are\e[1;31m (default hx)*\e[0m:"
echo -e "\e[1;32m hx\e[0m      - Build disk image with Hexagonix"
echo -e "\e[1;32m hx.test\e[0m - Build test disk image with Hexagonix"
echo -e "\e[1;31m* The 'hx' option will be selected if no parameter is passed after '-i'!\e[0m"

}

function showVersion() {

echo -e "hx: Hexagonix build utility, version $HX_VERSION"
echo
echo -e "\e[0mCopyright (c) 2015-2024 Felipe Miguel Nery Lunkes\e[0m"
echo -e "hx and hx modules are licensed under BSD-3-Clause and comes with no warranty."

}

function parametersRequired() {

echo
echo -e "You must provide at least one \e[1;94mvalid\e[0m parameter."

showMainHelp

}

#-------------------------------- Division --------------------------------#

# Collective build section of system components

function manageBuild() {

getBuildInformation

case $PT2 in

hx) setImageBuildOnLinux; exit;;
hx.test) setTestImageBuildOnLinux; exit;;
bsd) setImageBuildOnBSD; exit;;
UNIX) setImageBuildOnUNIXSolaris; exit;;
*) setImageBuildOnLinux; exit;; # Assume hx -i hx

esac

}

function manageComponentBuild() {

mkdir -p $BUILD_DIRECTORY
mkdir -p $BUILD_DIRECTORY/bin
mkdir -p $BUILD_DIRECTORY/etc

case $PT2 in

hexagon) callHXMod hexagon; exit;;
HBoot) callHXMod hboot; exit;;
saturno) callHXMod saturno; exit;;
unixland) callHXMod unix; exit;;
andromedaland) callHXMod andromeda; exit;;
hexagonix) hexagonix; exit;;
hx) buildAllComponents; exit;;
*) buildAllComponents; exit;;

esac

}

#-------------------------------- Division --------------------------------#

# Configuration section for build the system

function setImageBuildOnLinux() {

export HOST="LINUX"

checkStaticFiles

setReleaseBuild

buildHexagonix

}

function setImageBuildOnBSD() {

export HOST="BSD"

checkStaticFiles

setReleaseBuild

buildHexagonix

}

function setImageBuildOnUNIXSolaris() {

export HOST="UNIX"

checkStaticFiles

setReleaseBuild

buildHexagonix

}

function setTestImageBuildOnLinux() {

export HOST="LINUX"

checkStaticFiles

setTestBuild

buildHexagonix

}

#-------------------------------- Division --------------------------------#

function setTestBuild() {

# Here we will generate a small image, 2 Mb, smaller and just for testing.
# This image should not be used for the installation package.
# This image should be not compatible with virtual machines running with 2 virtual
# disk attached (system limitation).

export ISK_IMAGE_SIZE=2097012
export TEMP_IMAGE_SIZE=2048

}

function setReleaseBuild() {

# Here we will define an official size image, which takes longer to generate.
# This image is appropriate for the Hexagonix installation package and official releases.

export DISK_IMAGE_SIZE=47185920
export TEMP_IMAGE_SIZE=92160

}

#-------------------------------- Division --------------------------------#

function buildAllComponents() {

MSG="Building the Hexagonix"

clear

banner

callHXMod saturno
callHXMod hboot
callHXMod hexagon
callHXMod unix
callHXMod andromeda

finishStep
allDone

}

#-------------------------------- Division --------------------------------#

# System image build section

function buildHexagonix() {

callHXMod diskBuilder

}

#-------------------------------- Division --------------------------------#

# hx virtual machine management section

function manageVirtualMachines() {

callHXMod vm $PT2;

}

#-------------------------------- Division --------------------------------#

# hx utilities section

function cleanObjectsInSourceTree() {

clear

MSG="hx: clear system tree"

banner

echo "Performing system tree cleanup..."
echo -n " > Cleaning up generated components and system images..."

rm -rf $MOUNT_POINT_DIRECTORY $BUILD_DIRECTORY Hexagonix temp.img hexagonix.img
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

function startIndentModule() {

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

function startConfigureModule() {

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

function checkStaticFiles() {

# Let's check if the essential static files have already been generated before.
# If not, we will generate them

if [ -e Dist/etc/base.ocl ] ; then

echo "Static files present."

else

clear

MSG="Building the Hexagonix"

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

function displayStatistics() {

clear

MSG="Statistics"

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

function showBuildFlags() {

clear

MSG="Hexagonix build flags"

banner

echo "HBoot build flags:"
echo -e " > \e[1;32m$CONDENSED_HBOOT_FLAGS\e[0m"
echo "Hexagon build flags:"
echo -e " > \e[1;32m$CONDENSED_HEXAGON_FLAGS\e[0m"
echo "Common userland build flags:"
echo -e " > \e[1;32m$CONDENSED_COMMON_FLAGS\e[0m"

echo

allDone
finishStep

}

function installBuildDependencies() {

if test "`whoami`" != "root" ; then

tryWithSudo

exit

fi

MSG="Install dependencies"

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

function updateDiskImages() {

MSG="Update images"

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

function updateAuthorized() {

cd hexagonix

rm -rf hexagonix.img hexagonix.vdi

wget https://github.com/hexagonix/hexagonix/blob/main/hexagonix.img
wget https://github.com/hexagonix/hexagonix/blob/main/hexagonix.vdi

finishStep
allDone

}

function infoRepo() {

MSG="Repos information"

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
echo -e " > Remote host: \e[1;94m$REMOTE\e[0m"
echo

finishStep
allDone

}

function updateRepositories() {

MSG="Update repos"

banner

echo "You are about to update all repositories with the server, keeping current"
echo "branch. To change branch and update, use hx -un <branch>."
echo
echo "Update info:"
echo -e " > Branch: \e[1;94m$MAIN_BRANCH\e[0m"
echo -e " > Remote host: \e[1;94mhttps://github.com/hexagonix\e[0m"
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

function switchBranchAndUpdateRepositories() {

MSG="Update branch and repositories"

banner

echo "You are about to update all system repositories with the server,"
echo "after switching to the given branch."
echo
echo "Update info:"
echo -e " > Branch: \e[1;94m$PT2\e[0m"
echo -e " > Remote host: \e[1;94m$REMOTE\e[0m"
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

function cloneRepositories() {

clear

MSG="Build the Hexagonix"

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

function checkCloneDependencies() {

clear

MSG="Build the Hexagonix"

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

function finish() {

exit

}

function tryWithSudo() {

clear

MSG="hx: you need to be root"

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

# Hx entry point, variable definition and parameter processing
#
#
# Copyright (c) 2015-2024 Felipe Miguel Nery Lunkes
# All rights reserved

# hx info
# These variables MUST be exported. They must be accessible to child shell instances


export HX_NAME=$0
export HX_VERSION="14.0.0-ALPHA2"

# Modules directory

export MOD_DIR="$(pwd)/Scripts/modules"

# Imports

# Essential modules

. $MOD_DIR/buildInfo.hx
. $MOD_DIR/common.hx

# Export arguments

PT1=$1
PT2=$2
PT3=$3
PT4=$4
PT5=$5
PT6=$6

main $1
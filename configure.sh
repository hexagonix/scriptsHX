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
#                         Copyright (c) 2015-2025 Felipe Miguel Nery Lunkes
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
# Copyright (c) 2015-2025, Felipe Miguel Nery Lunkes
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
# $ENGLISH$
#
# This script must be in the root of the project

function main() {

case $1 in

build) build; exit;;
user) users; exit;;
uninstall) uninstall; exit;;
-h) showMainHelp; exit;;
--install) installDependencies; exit;;
--version) showVersion; exit;;
*) configureBuild; exit;;

esac

}

function showMainHelp() {

case $PT2 in

-v) showVirtualMachineHelp; exit;;
-i) showBuildHelp; exit;;

esac 

echo
echo -e "hx configure $CONFIGURE_VERSION help:"
echo
echo -e "\e[1;94mMain\e[0m available parameters:"
echo
echo -e "\e[1;32mbuild\e[0m     - Configure and create static files needed fot build the system"
echo -e "\e[1;32muser\e[0m      - Build user database from configuration files"
echo -e "\e[1;32muninstall\e[0m - Uninstall hx dependencies in your computer"
echo -e "\e[1;32m--version\e[0m - Show hx configure version"
echo -e "\e[1;32m--install\e[0m - Install the dependencies needed to build and run Hexagonix locally"
echo -e "\e[1;32m-h\e[0m        - Show main help"
echo
echo  "See the complete documentation at: https://github.com/hexagonix/Doc"
echo

}

function installDependencies() {

banner

echo "The configure will install all the dependencies needed to build and"
echo "run Hexagonix locally. We must be root to do that."
echo 
echo "Press <ENTER> to continue or CTRL-C to exit without install dependencies."

read continue

sudo apt install $BUILD_DEPENDENCIES

finish

}

function verifyDependencies() {

echo -e "Checking dependencies needed to build the system..."

# Now let's check each build engine dependency

# Dependency 1

echo -n " > flat assembler "

if [ -e /usr/bin/fasm ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Dependency 2

echo -n " > qemu "

if [ -e /usr/bin/qemu-system-i386 ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;94mYou can start building the system without this dependency\e[0m."

fi

# Dependency 3

echo -n " > nasm "

if [ -e /usr/bin/nasm ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;94mYou can start building the system without this dependency\e[0m."

fi

# Dependency 4

echo -n " > dd "

if [ -e /usr/bin/dd ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Dependency 5

echo -n " > chown "

if [ -e /usr/bin/chown ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;94mYou can start building the system without this dependency\e[0m."

fi

# Dependency 6

echo -n " > cloc "

if [ -e /usr/bin/cloc ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;94mYou can start building the system without this dependency\e[0m."

fi

# Dependency 7

echo -n " > uuid "

if [ -e /usr/bin/uuid ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;94mYou can start building the system without this dependency\e[0m."
echo -e "   > \e[1;31mWarning: The build may fail\e[0m."

fi

finish

# Now let's check if the scripts are available and make them executable

echo -e "Checking utilities and modules needed to build the system..."

# Module 1

echo -n " > System build and run utility (hx) "

if [ -e hx ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x hx

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Module 2

echo -n " > External utilities build module (Contrib.sh) "

if [ -e Contrib/Contrib.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Contrib/Contrib.sh

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Module 3

echo -n " > Unix utilities build module (Unix.sh) "

if [ -e Apps/Unix/Unix.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Apps/Unix/Unix.sh

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Module 4

echo -n " > Andromeda-Hexagonix application build module (Apps.sh) "

if [ -e Apps/Andromeda/Apps.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Apps/Andromeda/Apps.sh

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Module 5

echo -n " > Hexagonix font build module (fonts.sh) "

if [ -e Fonts/fonts.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Fonts/fonts.sh

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Now let's install the dependencies already present (no need to obtain)

# Let's test whether or not we can install hx in /usr/bin...

if test "`whoami`" != "root" ; then

echo -e " \e[1;31m[!] Unable to install hx to /usr/bin. Root user privileges required.\e[0m"
echo -e " \e[1;31m[!] Use sudo ./configure.sh to install hx.\e[0m"

fi

if test "`whoami`" == "root" ; then

# Install hx

echo -n " > Installing/updating hx (destination: /usr/bin)... "

cp hx /usr/bin

fi

if [ -e /usr/bin/hx ] ; then

if test "`whoami`" == "root" ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x /usr/bin/hx

echo -e " [\e[94mExecutable\e[0m]"

fi

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mVocê deve usar a cópia local de hx para executar as operações\e[0m."

fi

finish

}

function build() {

BUILD=$(uuid -m -v 4)

echo -e "Configuring system build data..."

# First, let's build the base

cd Dist/etc

if [ -e base.ocl ] ; then

echo " > Removing previous build and base version information..."

sudo rm base.ocl

fi

echo -n " > Processing .conf file and creating system information file... "
echo -e $(cat base.conf)$VERSION"]"$CODENAME'"'$UPDATEPACK"#"$RELEASE"!"$BUILD">" >> base.ocl
echo -e "[\e[32mOk\e[0m]"

if [ -e hexgnix.unx ] ; then

echo " > Removing previous Hexagonix build and version database..."

sudo rm hexgnix.unx

fi

echo -n " > Processing .conf file and creating UNX-XML... "
echo -e $(cat hexgnix.conf)'  "version": "'$VERSION'"' >> hexgnix.unx
echo '  "codename": "'$CODENAME'"' >> hexgnix.unx
echo '  "updatePack": "'$UPDATEPACK'"' >> hexgnix.unx
echo '  "branch": "'$RELEASE'"' >> hexgnix.unx
echo '  "build": "'$BUILD'"' >> hexgnix.unx
echo '  "buildDate": "'$(date)'"' >> hexgnix.unx
echo "}" >> hexgnix.unx
echo -e "[\e[32mOk\e[0m]"
cd ..
cd ..

finish

}

function host() {

echo -e "Configuring hostname..."

cd Dist/etc

if [ -e host ] ; then

echo " > Removing previous host configuration..."

sudo rm host

fi

echo -n " > Processing .conf file and creating host configuration... "
echo $CODENAME$(cat host.conf) >> host
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

finish

}

function shrc() {

echo -e "Configuring shrc..."

cd Dist/etc

if [ -e shrc ] ; then

echo " > Removing previous shrc configuration..."

sudo rm shrc

fi

echo -n " > Creating shrc configuration... "
echo "Welcome to Hexagonix $VERSION ($RELEASE)"  >> shrc
echo "Hexagonix is licenced under BSD-3-Clause and comes with no warranty." >> shrc
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

finish

}

function users() {

echo -e "Configuring users..."

cd Dist/etc

if [ -e passwd ] ; then

echo " > Removing previous user database..."

sudo rm passwd

fi

echo -n " > Processing .conf file and creating user database... "
echo -e $(cat passwd.conf) >> passwd
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

finish

}

function init() {

echo -e "Configuring rc (startup script)..."

cd Dist/etc

if [ -e rc ] ; then

echo " > Removing previous rc (startup script)..."

sudo rm rc

fi

echo -n " > Processing .conf file and creating rc (startup script)... "
echo -e $(cat rc.conf) >> rc
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

finish

}

function finish() {

echo -e "[\e[32mStep completed successfully\e[0m]"

}

function uninstall() {

banner

echo -e "Removing dependencies installed on your computer..."
echo
echo -n " > Removing hx from /usr/bin... "

if [ -e /usr/bin/hx ] ; then

sudo rm -rf /usr/bin/hx

else

echo -e "[\e[94mPreviously removed\e[0m] "

finish

exit

fi

if [ -e /usr/bin/hx ] ; then

echo -en "[\e[1;31mFail\e[0m]"

else

echo -en "[\e[32mOk\e[0m]"

echo -e " [\e[94mRemoved\e[0m]"

fi

finish

}

function configureBuild() {

banner

echo -e "Checking dependencies and configuring system build settings..."
echo

verifyDependencies
build
users
init
host
shrc

echo -e "[\e[32mAll ready!\e[0m]"

}

function banner() {

clear

echo -e "******************************************************************************"
echo
echo -e " ┌┐ ┌┐                                \e[1;94mHexagonix Operating System\e[0m"
echo -e " ││ ││"
echo -e " │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright (c) 2015-2025 Felipe Miguel Nery Lunkes\e[0m"
echo -e " │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘             \e[1;94mAll rights reserved.\e[0m"
echo -e " ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐"
echo -e " └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘"
echo -e "              ┌─┘│                   \e[1;32mConfigure build environment\e[0m"
echo -e "              └──┘"
echo
echo -e "******************************************************************************"
echo

}

function showVersion() {

echo "hx build configuration module, version $CONFIGURE_VERSION"
echo
echo -e "\e[0mCopyright (c) 2015-2025 Felipe Miguel Nery Lunkes\e[0m"
echo -e "hx and hx modules are licensed under BSD-3-Clause and comes with no warranty."

}

export CONFIGURE_VERSION="6.5.0"

CONFIGURE1=$2
CONFIGURE2=$3
CONFIGURE3=$4
CONFIGURE4=$5
BUILD_DEPENDENCIES="fasm nasm cloc qemu-system-x86 uuid"
VERSION=$(cat Dist/etc/version.def)
CODENAME=$(cat Dist/etc/codename.def)
RELEASE=$(cat Dist/etc/release.def)
UPDATEPACK=$(cat Dist/etc/update.def)

main $1
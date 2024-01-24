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

# Version 5.0.0

# $PORTUGUÊS$
#
# Esse script deve ficar na raiz do projeto
#
# $ENGLISH$
#
# This script must be in the root of the project

verifyDependencies()
{

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

finish

# Now let's check if the scripts are available and make them executable

echo -e "Checking scripts and utilities needed to build the system..."

# Script 1

echo -n " > System build and run script (hx) "

if [ -e hx ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x hx

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Script 2

echo -n " > Script for building external utilities (Contrib.sh) "

if [ -e Contrib/Contrib.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Contrib/Contrib.sh

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Script 3

echo -n " > Unix utilities build script (Unix.sh) "

if [ -e Apps/Unix/Unix.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Apps/Unix/Unix.sh

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Script 4

echo -n " > Andromeda-Hexagonix application build script (Apps.sh) "

if [ -e Apps/Andromeda/Apps.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Apps/Andromeda/Apps.sh

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi

# Script 5

echo -n " > Hexagonix font build script (fontes.sh) "

if [ -e Fontes/fontes.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Fontes/fontes.sh

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

build()
{

echo -e "Configuring system build data..."

# First, let's build the base

cd Dist/etc

if [ -e base.ocl ] ; then

echo " > Removing previous build and base version information..."

rm base.ocl

fi

echo -n " > Processing .conf file and setting configuration file... "
echo -e $(cat base.conf)$VERSION"]"$CODENOME'"'$VERSION"#"$RELEASE"!"$BUILD">" >> base.ocl
echo -e "[\e[32mOk\e[0m]"

if [ -e hexgnix.unx ] ; then

echo " > Removing previous Hexagonix build and version database..."

rm hexgnix.unx

fi

echo -n " > Processing .conf file and creating UNX-XML... "
echo -e $(cat hexgnix.conf)"<VERSION> "$VERSION" </VERSION>" >> hexgnix.unx
echo "<CODENAME> $CODENOME </CODENAME>" >> hexgnix.unx
echo "<UPDATEPACK> $VERSION </UPDATEPACK>" >> hexgnix.unx
echo "<BRANCH> $RELEASE </BRANCH>" >> hexgnix.unx
echo "<BUILD> $BUILD </BUILD>" >> hexgnix.unx
echo "<BUILDDATE> "$(date)" </BUILDDATE>" >> hexgnix.unx
echo "</Hexagonix>" >> hexgnix.unx
echo -e "[\e[32mOk\e[0m]"
cd ..
cd ..

finish

}

host()
{

echo -e "Configuring hostname..."

cd Dist/etc

if [ -e host ] ; then

echo " > Removing previous host configuration..."

rm host

fi

echo -n " > Processing .conf file and creating host configuration... "
echo $CODENOME$(cat host.conf) >> host
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

finish

}

shrc()
{

echo -e "Configuring shrc..."

cd Dist/etc

if [ -e shrc ] ; then

echo " > Removing previous shrc configuration..."

rm shrc

fi

echo -n " > Creating shrc configuration... "
echo "Welcome to Hexagonix $VERSION ($RELEASE)"  >> shrc
echo "Hexagonix is licenced under BSD-3-Clause and comes with no warranty." >> shrc
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

finish

}

users()
{

echo -e "Configuring users..."

cd Dist/etc

if [ -e passwd ] ; then

echo " > Removing previous user database..."

rm passwd

fi

echo -n " > Processing .conf file and creating user database... "
echo -e $(cat passwd.conf) >> passwd
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

finish

}

init()
{

echo -e "Configuring rc (startup script)..."

cd Dist/etc

if [ -e rc ] ; then

echo " > Removing previous rc (startup script)..."

rm rc

fi

echo -n " > Processing .conf file and creating rc (startup script)... "
echo -e $(cat rc.conf) >> rc
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

finish

}

finish()
{

echo -e "[\e[32mStep completed successfully\e[0m]"

}

clean()
{

clear

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mHexagonix Operating System\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2015-2024 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘             \e[1;94mAll rights reserved.\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                   \e[1;32mConfigure build environment\e[0m        "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "Removing dependencies installed on your computer..."
echo
echo -n " > Removing hx from /usr/bin... "

if [ -e /usr/bin/hx ] ; then

rm -rf /usr/bin/hx

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

configureBuild()
{

clear

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mHexagonix Operating System\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2015-2024 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘             \e[1;94mAll rights reserved.\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                   \e[1;32mConfigure build environment\e[0m        "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
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

export CONFIGURE1=$2
export CONFIGURE2=$3
export CONFIGURE3=$4
export CONFIGURE4=$5
export BUILD=$(uuid -m -v 4)
export RELEASE=$(cat Dist/etc/release.def)
export CODENOME=$(cat Dist/etc/codenome.def)
export VERSION=$(cat Dist/etc/versao.def)

case $1 in

build) build; exit;;
user) users; exit;;
clean) clean; exit;;
*) configureBuild; exit;;

esac
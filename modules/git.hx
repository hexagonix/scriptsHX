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

function main() {

case $1 in

cloneRepositories) cloneRepositories; exit;;
updateDiskImages) updateDiskImages; exit;;
infoRepo) infoRepo; exit;;
updateRepositories) updateRepositories; exit;;
switchBranchAndUpdateRepositories) switchBranchAndUpdateRepositories; exit;;

esac 

}

function cloneRepositories() {

clear

export MSG="Clone system repositories"

callHXMod common banner

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

function updateDiskImages() {

export MSG="Update system images"

callHXMod common banner

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
n) exit;;
N) exit;;
*) exit;;

esac

}

function updateAuthorized() {

cd hexagonix

rm -rf hexagonix.img hexagonix.vdi

wget https://github.com/hexagonix/hexagonix/blob/main/hexagonix.img
wget https://github.com/hexagonix/hexagonix/blob/main/hexagonix.vdi

callHXMod common finishStep
callHXMod common allDone

}

function infoRepo() {

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
echo -e " > Remote host: \e[1;94m$REMOTE\e[0m"
echo

callHXMod common finishStep
callHXMod common allDone

}

function updateRepositories() {

export MSG="Update repositories"

callHXMod common banner

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

callHXMod common finishStep
callHXMod common allDone

}

function switchBranchAndUpdateRepositories() {

export MSG="Update branch and repositories"

callHXMod common banner

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

callHXMod common finishStep
callHXMod common allDone

}

# Imports

. $MOD_DIR/macros.hx

# Constants

MOD_VER="0.3"

main $1
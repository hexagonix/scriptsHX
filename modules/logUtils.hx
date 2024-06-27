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

startBuildLog()
{

if [ -e $LOG ] ; then

rm -r $LOG

fi

# Create the log file header

echo -e "Hexagonix Operating System build and statistics report" >> $LOG
echo "-------------------------------------------------------" >> $LOG
echo -e "\nHexagonix Operating System" >> $LOG
echo "Copyright (c) 2015-2024 Felipe Miguel Nery Lunkes" >> $LOG
echo "All rights reserved." >> $LOG
echo -e "\nHexagonix is licenced under BSD-3-Clause and comes with no warranty.\n" >> $LOG
echo "-------------------------------------------------------" >> $LOG
echo -e "\nIn this file, you have access to the complete log of the build process of" >> $LOG
echo "Hexagonix components. You can also use it to identify the environment used in" >> $LOG
echo "build, as well as errors found in the process." >> $LOG
echo -e "\nhx version: $HX_VERSION" >> $LOG
echo -e "\nBuild task id: $BUILD_ID" >> $LOG
echo -e "\nInformation about the current build of Hexagonix:" >> $LOG
echo " > Hexagonix version: $HEXAGONIX_VERSION" >> $LOG
echo " > Software revision: $HEXAGONIX_REVISION" >> $LOG
echo " > Release name: $HEXAGONIX_CODENAME" >> $LOG
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
echo " > Remote host: $REMOTE" >> $LOG
echo -e "\nInformation about the current build environment:" >> $LOG
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

echo -e "\n > Build flags:" >> $LOG
echo "   > HBoot build flags: $CONDENSED_HBOOT_FLAGS" >> $LOG
echo "   > Hexagon build flags: $CONDENSED_HEXAGON_FLAGS" >> $LOG
echo "   > Common userland build flags: $CONDENSED_COMMON_FLAGS" >> $LOG
echo -e "\n----------------------------------------------------------------------\n" >> $LOG

}

showCreateInstallerInfo()
{

echo "> Disk image '$IMAGE_FILENAME' and VM disk image '$(basename $IMAGE_FILENAME .img).vdi' generated successfully." >> $LOG
echo -e "\nUse './hx -v hx' to test running the system on the generated image or copy" >> $LOG
echo "the image to the installer 'Inst' directory to generate an Linux-based install" >> $LOG
echo "image for transfer to physical disk." >> $LOG
echo -e "\n----------------------------------------------------------------------\n" >> $LOG

}

finishBuildLog()
{

echo -n "End date/time of this log: " >> $LOG
date >> $LOG
echo -e "\n----------------------------------------------------------------------\n" >> $LOG

}

MOD_VER="0.1"

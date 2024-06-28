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

case $1 in 

generalBuildError) generalBuildError; exit;;
buildError) buildError; exit;;
banner) banner; exit;;
finishStep) finishStep; exit;;
allDone) allDone; exit;;
suRequired) suRequired; exit;;

esac 

}

function generalBuildError() {

echo -e "An error occurred while building some system component.\n"
echo -e "Check the status of the components and use the above error outputs to verify the problem.\n"
echo -e "View the log file 'log.log', for more information about the error(s).\n"

umount $MOUNT_POINT_DIRECTORY/ >> /dev/null
umount $BUILD_DIRECTORY/ >> /dev/null

exit

}

function buildError() {

if test $VERBOSE -e 0; then

clear

elif test $VERBOSE -e 1; then

echo

fi

export MSG="System build error"

banner
echo -e "\n\e[1;31mSomething went wrong while mounting the image:(\e[0m\n"
echo -e "Use the system generation script to verify the source of the problem.\n"

umount $MOUNT_POINT_DIRECTORY >> /dev/null
umount $BUILD_DIRECTORY/ >> /dev/null

exit

}

function banner() {

echo -e "******************************************************************************"
echo
echo -e " ┌┐ ┌┐                                \e[1;94mHexagonix Operating System\e[0m"
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

function finishStep() {

echo -e "[\e[32mStep completed successfully\e[0m]"

}

function allDone() {

echo -e "[\e[32mAll ready!\e[0m]"

}

function suRequired() {

clear

export MSG="hx: you need to be root"

banner

echo -e "\e[1;94mYou must be a root user to perform the requested action ;D\e[0m\n"

exit

}

# Constants

MOD_VER="0.3"

main $1
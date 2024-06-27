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

hx) vmHexagonixWithoutSnd; exit;;
hx.snd) vmHexagonixWithKVM; exit;;
hx.bsd) vmHexagonixOnBSDHost; exit;;
hx.serial) vmHexagonixWithoutSerialRedirection; exit;;
hx.p3) vmHexagonixPentium3; exit;;
*) vmHexagonixWithoutSnd; exit;; # Assume hx -v hx

esac

}

function vmHexagonixPentium3() {

QEMU_ARGS="--enable-kvm -serial file:Serial.txt -cpu $PROCESSOR -hda $DISK_IMAGE_PATH -m $MEMORY -audiodev $AUDIO_DEVICE -k pt-br"
NOTA="Using KVM and legacy processor (Pentium III)"

startVirtualMachine

}

function vmHexagonixWithoutSnd() {

QEMU_ARGS="--enable-kvm -serial file:Serial.txt -cpu host -hda $DISK_IMAGE_PATH -m $MEMORY -k pt-br"
DRV_SOUND="none"
NOTA="Using without sound device"

startVirtualMachine

}

function vmHexagonixOnBSDHost() {

QEMU_ARGS="-cpu $PROCESSOR -hda $DISK_IMAGE_PATH -m $MEMORY -k pt-br"
NOTA="BSD mode"

startVirtualMachine

}

function vmHexagonixWithKVM() {

QEMU_ARGS="--enable-kvm -serial file:Serial.txt -cpu host -hda $DISK_IMAGE_PATH -m $MEMORY -audiodev $AUDIO_DEVICE -k pt-br"
NOTA="Using KVM and serial output to file"

startVirtualMachine

}

function vmHexagonixWithoutSerialRedirection() {

QEMU_ARGS="-serial stdio -hda $DISK_IMAGE_PATH -cpu $PROCESSOR -m $MEMORY -k pt-br"
NOTA="Using serial output to console"

startVirtualMachine

}

function startVirtualMachine() {

if [ -e $DISK_IMAGE_PATH ] ; then

clear

MSG="hx: start virtual machine"

callHXMod common banner

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

function virtualMachineGeneralError() {

clear

MSG="hx: start virtual machine"

callHXMod common banner

echo -e "Error in request: disk image \e[1;94m'$DISK_IMAGE_PATH'\e[0m not found or fail"
echo -e "\e[0min some virtual machine component or parameter."
echo -e " > \e[1;31mYou CANNOT boot the system without this error.\e[0m"
echo -e "Error in request: \e[1;94mproblem while running virtual machine\e[0m."
echo -e " > \e[1;31mTry running the virtual machine again\e[0m."
echo

}

# Imports

. $MOD_DIR/macros.hx

# Constants

MOD_VER="0.2"

# Constants for virtual machine execution (QEMU)

DRV_SOUND="pcspk"
SYSTEM_ARCH="i386"
BSD_SYSTEM_ARCH="x86_64"
PROCESSOR="pentium3"
MEMORY=32
AUDIO_DEVICE="pa,id=audio0 -machine pcspk-audiodev=audio0"

main $1

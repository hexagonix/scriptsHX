#!/bin/bash

vmHexagonixPentium3()
{

QEMU_ARGS="--enable-kvm -serial file:Serial.txt -cpu $PROCESSOR -hda $DISK_IMAGE_PATH -m $MEMORY -audiodev $AUDIO_DEVICE -k pt-br"
NOTA="Using KVM and legacy processor (Pentium III)"

startVirtualMachine

}

vmHexagonixWithoutSnd()
{

QEMU_ARGS="--enable-kvm -serial file:Serial.txt -cpu host -hda $DISK_IMAGE_PATH -m $MEMORY -k pt-br"
DRV_SOUND="none"
NOTA="Using without sound device"

startVirtualMachine

}

vmHexagonixOnBSDHost()
{

QEMU_ARGS="-cpu $PROCESSOR -hda $DISK_IMAGE_PATH -m $MEMORY -k pt-br"
NOTA="BSD mode"

startVirtualMachine

}

vmHexagonixWithKVM()
{

QEMU_ARGS="--enable-kvm -serial file:Serial.txt -cpu host -hda $DISK_IMAGE_PATH -m $MEMORY -audiodev $AUDIO_DEVICE -k pt-br"
NOTA="Using KVM and serial output to file"

startVirtualMachine

}

vmHexagonixWithoutSerialRedirection()
{

QEMU_ARGS="-serial stdio -hda $DISK_IMAGE_PATH -cpu $PROCESSOR -m $MEMORY -k pt-br"
NOTA="Using serial output to console"

startVirtualMachine

}

startVirtualMachine()
{

if [ -e $DISK_IMAGE_PATH ] ; then

clear

MSG="hx: start virtual machine"

banner

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

MSG="hx: start virtual machine"

banner

echo -e "Error in request: disk image \e[1;94m'$DISK_IMAGE_PATH'\e[0m not found or fail"
echo -e "\e[0min some virtual machine component or parameter."
echo -e " > \e[1;31mYou CANNOT boot the system without this error.\e[0m"
echo -e "Error in request: \e[1;94mproblem while running virtual machine\e[0m."
echo -e " > \e[1;31mTry running the virtual machine again\e[0m."
echo

}

. $MOD_DIR/common.hx

MOD_VER="0.1"

# Constants for virtual machine execution (QEMU)

DRV_SOUND="pcspk"
SYSTEM_ARCH="i386"
BSD_SYSTEM_ARCH="x86_64"
PROCESSOR="pentium3"
MEMORY=32
AUDIO_DEVICE="pa,id=audio0 -machine pcspk-audiodev=audio0"

case $1 in

hx) vmHexagonixWithoutSnd; exit;;
hx.snd) vmHexagonixWithKVM; exit;;
hx.bsd) vmHexagonixOnBSDHost; exit;;
hx.serial) vmHexagonixWithoutSerialRedirection; exit;;
hx.p3) vmHexagonixPentium3; exit;;
*) vmHexagonixWithoutSnd; exit;; # Assume hx -v hx

esac


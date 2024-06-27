#!/bin/bash

generalBuildError(){

echo -e "An error occurred while building some system component.\n"
echo -e "Check the status of the components and use the above error outputs to verify the problem.\n"
echo -e "View the log file 'log.log', for more information about the error(s).\n"

umount $MOUNT_POINT_DIRECTORY/ >> /dev/null
umount $BUILD_DIRECTORY/ >> /dev/null

exit

}

buildError()
{

if test $VERBOSE -e 0; then

clear

elif test $VERBOSE -e 1; then

echo

fi

MSG="System build error"

banner
echo -e "\n\e[1;31mSomething went wrong while mounting the image:(\e[0m\n"
echo -e "Use the system generation script to verify the source of the problem.\n"

umount $MOUNT_POINT_DIRECTORY >> /dev/null
umount $BUILD_DIRECTORY/ >> /dev/null

exit

}


callHXMod() {

$MOD_DIR/$1.hx $2
enforceRootDirectory

}

enforceRootDirectory()
{

cd $ROOT_DIR

}

banner()
{

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

finishStep()
{

echo -e "[\e[32mStep completed successfully\e[0m]"

}

allDone()
{

echo -e "[\e[32mAll ready!\e[0m]"

}

sureq()
{

clear

MSG="hx: you need to be root"

banner

echo -e "\e[1;94mYou must be a root user to perform the requested action ;D\e[0m\n"

exit

}


MOD_VER="0.1"
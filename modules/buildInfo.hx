#!/bin/bash

infoBuild()
{

clear

MSG="System information"

banner

echo -e "Information about the \e[1mcurrent\e[0m build of the system:"
echo -e " > Hexagonix version: \e[1;32m$HEXAGONIX_VERSION\e[0m"
echo -e " > Software revision: \e[1;32m$HEXAGONIX_REVISION\e[0m"
echo -e " > Release name: \e[1;32m$HEXAGONIX_CODENAME\e[0m"
echo -e " > Disk image location: \e[1;32m$IMAGE_PATH/$IMAGE_FILENAME\e[0m"
echo

}

getBuildInformation()
{

# Hexagonix version data

export HEXAGONIX_REVISION=$(cat Dist/etc/release.def)
export HEXAGONIX_CODENAME=$(cat Dist/etc/codename.def)
export HEXAGONIX_VERSION=$(cat Dist/etc/version.def)

}

MOD_VER="0.1"
#!/bin/bash

buildHexagonKernel()
{

echo -e "Starting Hexagon builder mod version $MOD_VERSION...\n" >> $LOG

cd Hexagon

echo
echo -en "\e[1;94mBuilding the Hexagon kernel...\e[0m"

echo -e "Building the Hexagon kernel... {\n" >> $LOG

fasm kern/Hexagon.asm Hexagon -d $HEXAGON_FLAGS >> $LOG || generalBuildError

cp Hexagon $BUILD_DIRECTORY/bin

rm -r Hexagon

echo -e " [\e[32mOk\e[0m]"

echo -e "\n} Hexagon kernel built successfully.\n" >> $LOG
echo -e "----------------------------------------------------------------------\n" >> $LOG

}

. $MOD_DIR/common.hx

MOD_VERSION="0.1"

buildHexagonKernel
#!/bin/bash

buildSaturnoBootLoader()
{

echo -e "Starting Saturno/MBR builder mod version $MOD_VERSION...\n" >> $LOG

echo -e "\e[1;94mBuilding Hexagon startup components (step 1/2)...\e[0m {\n"

echo -e "Building Hexagon startup components (step 1/2)... {\n" >> $LOG

echo -e "\e[1;94mHexagon bootloader - Saturno (1st stage)...\e[0m\n"

echo "Hexagon bootloader - Saturno (1st stage)...\n" >> $LOG

cd Boot

cd Saturno

fasm saturno.asm saturno.img >> $LOG || generalBuildError

echo >> $LOG

fasm mbr.asm mbr.img >> $LOG || generalBuildError

mv *.img $BUILD_DIRECTORY

echo -e "} [\e[32mSaturno/MBR built successfully\e[0m]."

echo >> $LOG

echo -e "\n} Saturno/MBR built successfully.\n" >> $LOG
echo -e "----------------------------------------------------------------------\n" >> $LOG

}

. $MOD_DIR/common.hx

MOD_VERSION="0.1"

buildSaturnoBootLoader
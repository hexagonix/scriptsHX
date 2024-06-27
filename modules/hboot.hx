#!/bin/bash

buildHBoot(){

echo -e "Starting HBoot builder mod version $MOD_VERSION...\n" >> $LOG

echo -e "\e[1;94mBuilding Hexagon startup components (step 2/2)...\e[0m {\n"

echo -e "Building Hexagon startup components (step 2/2)... {\n" >> $LOG

echo -e "\e[1;94mBuilding Hexagon Boot - HBoot (2nd stage)...\e[0m\n"

echo -e " > Building Hexagon Boot - HBoot (2nd stage)...\n" >> $LOG

cd "Boot"
cd "HBoot"

fasm hboot.asm ../hboot -d $HBOOT_FLAGS >> $LOG || generalBuildError

cd Mods

if [ -e Spartan.asm ] ; then

for i in *.asm
do

    echo -en "Building HBoot compatible module \e[1;94m$(basename $i .asm).mod\e[0m..."

    echo -e "\n > Building HBoot compatible module $(basename $i .asm).mod..." >> $LOG

    fasm $i ../../`basename $i .asm`.mod -d $COMMON_FLAGS >> $LOG

    echo -e " [\e[32mOk\e[0m]"

done

fi

cd ..
cd ..

mv hboot $BUILD_DIRECTORY

if [ -e Spartan.mod ] ; then

mv *.mod $BUILD_DIRECTORY/

fi

echo
echo -e "} [\e[32mHBoot built successfully\e[0m]."

echo -e "\n} Successfully built HBoot.\n" >> $LOG
echo -e "----------------------------------------------------------------------\n" >> $LOG

}

. $MOD_DIR/common.hx

MOD_VERSION="0.1"

buildHBoot
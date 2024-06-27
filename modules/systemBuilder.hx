#!/bin/bash

systemBuilder()
{

echo -e "Starting Hexagonix system builder mod version $MOD_VER...\n" >> $LOG

MSG="Building the Hexagonix"

clear

banner

echo "Building the Hexagonix..."
echo

mkdir -p $BUILD_DIRECTORY
mkdir -p $BUILD_DIRECTORY/bin
mkdir -p $BUILD_DIRECTORY/etc

callHXMod saturno
callHXMod hboot
callHXMod hexagon
callHXMod unix
callHXMod andromeda

echo -e "Configuring and copying Hexagonix static files... {\n" >> $LOG

cd Dist

echo "> Copying static configuration files (generated by configure.sh)..." >> $LOG

cd etc/

cp rc $BUILD_DIRECTORY/etc

echo " > rc successfully copied." >> $LOG

cp passwd $BUILD_DIRECTORY/etc

echo " > passwd successfully copied." >> $LOG

cp host $BUILD_DIRECTORY/etc

echo " > host configuration file successfully copied." >> $LOG

cp *.unx $BUILD_DIRECTORY/etc

echo " > *.unx files successfully copied." >> $LOG

cp base.ocl $BUILD_DIRECTORY/hexgnix.ocl
cp shrc $BUILD_DIRECTORY/etc

echo " > Hexagonix version files successfully copied." >> $LOG

cd ..

echo "> Copying Hexagonix utility manuals..." >> $LOG

cd man

cp *.man $BUILD_DIRECTORY

cd ..
cd ..

cd Fonts/

echo "> Checking for additional fonts to build..." >> $LOG

if [ -e aurora.asm ] ; then

echo -e "There are graphic fonts to be built and copied... [\e[32mOk\e[0m]"
echo " > There are graphic fonts to be built and copied..." >> $LOG

./fonts.sh

cp *.fnt $BUILD_DIRECTORY
rm *.fnt

echo
echo -n "Fonts copied"
echo -e " [\e[32mOk\e[0m]"
echo " > Fonts copied." >> $LOG
echo

else

echo " > There are no graphic fonts to be built and copied..." >> $LOG
echo -e "There are no graphic fonts to build and copy... [\e[32mOk\e[0m]"
echo

fi

# Let's also copy the header file to be able to develop on Hexagonix

cd ..

echo "> Copying core development libraries..." >> $LOG
echo "Copying core development libraries..."
echo

cd lib/fasm

cp hexagon.s $BUILD_DIRECTORY
cp console.s $BUILD_DIRECTORY
cp macros.s $BUILD_DIRECTORY

cd Estelar

cp estelar.s $BUILD_DIRECTORY

cd ..
cd ..

cd samples

cp * $BUILD_DIRECTORY

cd ..
cd ..

echo -n "Libraries copied"
echo -e " [\e[32mOk\e[0m]"
echo

echo -e "\n} Success configuring and copying Hexagonix configuration files.\n" >> $LOG
echo -e "----------------------------------------------------------------------\n" >> $LOG

callHXMod contribBuilder

}

. $MOD_DIR/common.hx 

MOD_VER="0.1"

systemBuilder
#!/bin/bash

contribBuilder() 
{

echo -e "Starting contrib builder mod version $MOD_VER...\n" >> $LOG

echo -e "Building additional (contrib) packages... {\n" >> $LOG

if [ -e Contrib/Contrib.sh ] ; then

echo -e "> There are additional packages to build.\n" >> $LOG

cd Contrib

./Contrib.sh $BUILD_DIRECTORY

cd ..

else

echo "> There are no additional packages to build." >> $LOG
echo "There are no additional packages to build."
echo

fi

echo -e "\n} Success processing additional (contrib) packages." >> $LOG
echo -e "\n> View the 'log.log' log file for more information of the build."
echo

}

MOD_VER="0.1"

contribBuilder
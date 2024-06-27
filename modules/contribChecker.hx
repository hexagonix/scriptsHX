#!/bin/bash

verifyContribPackages()
{

echo -e "Starting contrib checker mod version $MOD_VER...\n" >> $LOG

# Check if there are additional files to be added to the image.
# These files must be in the contrib directory.

if [ -e contrib/ ] ; then

cp contrib/* $MOUNT_POINT_DIRECTORY/

fi

}

. $MOD_DIR/common.hx

MOD_VER="0.1"

verifyContribPackages
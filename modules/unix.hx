#!/bin/bash

buildUnixUtil()
{

echo -e "Starting Unix environment builder mod version $MOD_VERSION...\n" >> $LOG

# Build Unix base applications

cd "Apps/Unix"

./Unix.sh $BUILD_DIRECTORY

}

. $MOD_DIR/common.hx

MOD_VER="0.1"

buildUnixUtil
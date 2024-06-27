#!/bin/bash

buildAndromedaApplications()
{

echo -e "Starting Hexagonix-Andromeda environment builder mod version $MOD_VERSION...\n" >> $LOG

# Build the Hexagonix-Andromeda applications

cd "Apps/Andromeda"

./Apps.sh $BUILD_DIRECTORY

}

MOD_VER="0.1"

buildAndromedaApplications
#!/bin/bash
# Esse script deve ficar na raiz do projeto
#
#;;************************************************************************************
#;;
#;;    
#;; ┌┐ ┌┐                                 Sistema Operacional Hexagonix®
#;; ││ ││
#;; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐    Copyright © 2016-2022 Felipe Miguel Nery Lunkes
#;; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘          Todos os direitos reservados
#;; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐
#;; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘
#;;              ┌─┘│          
#;;              └──┘                             Versão 1.0
#;;
#;;
#;;************************************************************************************

build() {

# Primeiro, vamos montar a base 

cd Dist/etc

if [ -e base.ocl ] ; then

rm base.ocl

fi	

echo -e $(cat base.conf)$BUILD">" >> base.ocl 


if [ -e hexgnix.unx ] ; then

rm hexgnix.unx

fi	

echo -e $(cat hexgnix.conf)"<BUILD> "$BUILD" </BUILD>" >> hexgnix.unx
echo -e "<DATA_BUILD> "$(date)" </DATA_BUILD>" >> hexgnix.unx
echo "</Hexagonix>" >> hexgnix.unx

cd ..
cd ..

}

export CONFIGURE1=$2
export CONFIGURE2=$3
export CONFIGURE3=$4
export CONFIGURE4=$5
export BUILD=$RANDOM

case $1 in

build) build; exit;;
*) build; exit;;

esac
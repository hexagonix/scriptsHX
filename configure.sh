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
#;;              ┌─┘│                 Licenciado sob licença BSD-3-Clause
#;;              └──┘          
#;;                                               Versão 3.5.1
#;;
#;;************************************************************************************
#;;
#;; Este arquivo é licenciado sob licença BSD-3-Clause. Observe o arquivo de licença 
#;; disponível no repositório para mais informações sobre seus direitos e deveres ao 
#;; utilizar qualquer trecho deste arquivo.
#;;
#;; BSD 3-Clause License
#;;
#;; Copyright (c) 2015-2022, Felipe Miguel Nery Lunkes
#;; All rights reserved.
#;; 
#;; Redistribution and use in source and binary forms, with or without
#;; modification, are permitted provided that the following conditions are met:
#;; 
#;; 1. Redistributions of source code must retain the above copyright notice, this
#;;    list of conditions and the following disclaimer.
#;;
#;; 2. Redistributions in binary form must reproduce the above copyright notice,
#;;    this list of conditions and the following disclaimer in the documentation
#;;    and/or other materials provided with the distribution.
#;;
#;; 3. Neither the name of the copyright holder nor the names of its
#;;    contributors may be used to endorse or promote products derived from
#;;    this software without specific prior written permission.
#;; 
#;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#;; DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#;; CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#;; OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#;; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#;;
#;; $HexagonixOS$

checarDependencias()
{

echo -e "Checking dependencies needed to build the system..."

# Agora vamos verificar cada dependência do mecanismo de construção

# Dependência 1

echo -n " > flat assembler "

if [ -e /usr/bin/fasm ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi	

# Dependência 2

echo -n " > qemu "

if [ -e /usr/bin/qemu-system-i386 ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;94mYou can start building the system without this dependency\e[0m."

fi	

# Dependência 3

echo -n " > nasm "

if [ -e /usr/bin/nasm ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;94mYou can start building the system without this dependency\e[0m."

fi	

# Dependência 4

echo -n " > dd "

if [ -e /usr/bin/dd ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi	

# Dependência 5

echo -n " > chown "

if [ -e /usr/bin/chown ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;94mYou can start building the system without this dependency\e[0m."

fi	

# Dependência 6

echo -n " > cloc "

if [ -e /usr/bin/cloc ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;94mYou can start building the system without this dependency\e[0m."

fi	

terminar

# Agora vamos checar se os scripts estão disponíveis e torná-los executáveis

echo -e "Checking scripts and utilities needed to build the system..."

# Script 1

echo -n " > System build and run script (hx) "

if [ -e hx ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x hx

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi	

# Script 2

echo -n " > Script for building external utilities (Externos.sh) "

if [ -e Externos/Externos.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Externos/Externos.sh 

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi	

# Script 3

echo -n " > Unix utilities build script (Unix.sh) "

if [ -e Apps/Unix/Unix.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Apps/Unix/Unix.sh 

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi	

# Script 4

echo -n " > Andromeda-Hexagonix application build script (Apps.sh) "

if [ -e Apps/Andromeda/Apps.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Apps/Andromeda/Apps.sh 

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi	

# Script 5

echo -n " > Hexagonix font build script (fonts.sh) "

if [ -e Fontes/fontes.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Fontes/fontes.sh 

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mYou CANNOT start building the system without this dependency\e[0m."

fi	

# Agora vamos instalar as dependências já presentes (sem necessidade de obtenção)

# Copiar hx

echo -n " > Copying/updating hx (destination: /usr/bin)... "

cp hx /usr/bin 

if [ -e /usr/bin/hx ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x /usr/bin/hx

echo -e " [\e[94mExecutable\e[0m]"

else

echo -e "[\e[31mNot found\e[0m]"
echo -e "   > \e[1;31mVocê deve usar a cópia local de hx para executar as operações\e[0m."

fi 

terminar 

}

build() {

echo -e "Configuring system build data..."

# Primeiro, vamos montar a base 

cd Dist/etc

if [ -e base.ocl ] ; then

echo " > Removing previous build and base version information..."

rm base.ocl

fi	

echo -n " > Processing .conf file and setting configuration file... "
echo -e $(cat base.conf)$VERSAO"]"$CODENOME'"'$VERSAO"#"$REVISAO"!"$BUILD">" >> base.ocl 
echo -e "[\e[32mOk\e[0m]"

if [ -e hexgnix.unx ] ; then

echo " > Removing previous Hexagonix build and version information..."

rm hexgnix.unx

fi	

echo -n " > Processing .conf file and creating UNX-XML... "
echo -e $(cat hexgnix.conf)"<VERSAO> "$VERSAO" </VERSAO>" >> hexgnix.unx
echo -e "<NOME> $CODENOME </NOME>" >> hexgnix.unx
echo -e "<PACOTE> $VERSAO </PACOTE>" >> hexgnix.unx
echo -e "<STATUS> $REVISAO </STATUS>" >> hexgnix.unx
echo -e "<DATA_BUILD> "$(date)" </DATA_BUILD>" >> hexgnix.unx
echo "</Hexagonix>" >> hexgnix.unx
echo -e "[\e[32mOk\e[0m]"
cd ..
cd ..

terminar

}

host()
{

echo -e "Configuring hostname..."

cd Dist/etc 

if [ -e host.unx ] ; then

echo " > Removing previous host configuration..."

rm host.unx

fi	

echo -n " > Processing .conf file and creating host configuration... "
echo -e $CODENOME$(cat host.conf) >> host.unx
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

terminar 

}

usuarios()
{

echo -e "Configuring users..."

cd Dist/etc 

if [ -e usuario.unx ] ; then

echo " > Removing previous user base..."

rm usuario.unx

fi	

echo -n " > Processing .conf file and creating user database... "
echo -e $(cat usuario.conf)"@"$CODENOME"|root&ash.app# # Usuario da versao" >> usuario.unx
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

terminar 

}

init()
{

echo -e "Configuring startup script..."

cd Dist/etc 

if [ -e init.unx ] ; then

echo " > Removing previous startup script..."

rm init.unx

fi	

echo -n " > Processing .conf file and creating startup script... "
echo -e $(cat init.conf) >> init.unx
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

terminar 

}

terminar()
{

echo -e "[\e[32mStep completed successfully\e[0m]"

}

limpar()
{

clear

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mHexagonix® Operating System\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘             \e[1;94mAll rights reserved.\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                   \e[1;32mConfigure build environment\e[0m        "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "Removing dependencies installed on your computer..."
echo
echo -n " > Removing hx from /usr/bin... "

if [ -e /usr/bin/hx ] ; then

rm -rf /usr/bin/hx

else

echo -e "[\e[94mPreviously removed\e[0m] "

terminar 

exit

fi 

if [ -e /usr/bin/hx ] ; then

echo -en "[\e[1;31mFail\e[0m]"

else

echo -en "[\e[32mOk\e[0m]"

echo -e " [\e[94mRemoved\e[0m]"

fi 

terminar 

}

configurar()
{

clear

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mHexagonix® Operating System\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘             \e[1;94mAll rights reserved.\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                   \e[1;32mConfigure build environment\e[0m        "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "Checking dependencies and configuring system build settings..."
echo

checarDependencias
build
usuarios
init
host

echo -e "[\e[32mAll ready!\e[0m]"

}

export CONFIGURE1=$2
export CONFIGURE2=$3
export CONFIGURE3=$4
export CONFIGURE4=$5
export BUILD=$RANDOM
export REVISAO=$(cat Dist/etc/revisao.def)
export CODENOME=$(cat Dist/etc/codenome.def)
export VERSAO=$(cat Dist/etc/versao.def)

case $1 in

build) build; exit;;
usuario) usuarios; exit;;
limpar) limpar; exit;;
*) configurar; exit;;

esac
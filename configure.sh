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

echo -e "Configurando dados de build do sistema..."

# Primeiro, vamos montar a base 

cd Dist/etc

if [ -e base.ocl ] ; then

echo " > Removendo informações de build e versão base anteriores..."

rm base.ocl

fi	

echo -n " > Processando arquivo .conf e definindo arquivo de configuração... "
echo -e $(cat base.conf)$VERSAO"]"$CODENOME'"'$VERSAO"#"$REVISAO"!"$BUILD">" >> base.ocl 
echo -e "[\e[32mOk\e[0m]"

if [ -e hexgnix.unx ] ; then

echo " > Removendo informações de build e versão do Hexagonix anteriores..."

rm hexgnix.unx

fi	

echo -n " > Processando arquivo .conf e criando UNX-XML... "
echo -e $(cat hexgnix.conf)"<BUILD> "$BUILD" </BUILD>" >> hexgnix.unx
echo -e "<DATA_BUILD> "$(date)" </DATA_BUILD>" >> hexgnix.unx
echo "</Hexagonix>" >> hexgnix.unx
echo -e "[\e[32mOk\e[0m]"
cd ..
cd ..

terminar

}

host()
{

echo -e "Configurando nome de host..."

cd Dist/etc 

if [ -e host.unx ] ; then

echo " > Removendo configuração de host anterior..."

rm host.unx

fi	

echo -n " > Processando arquivo .conf e criando configuração de host... "
echo -e $CODENOME$(cat host.conf) >> host.unx
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

terminar 

}

usuarios()
{

echo -e "Configurando usuários..."

cd Dist/etc 

if [ -e usuario.unx ] ; then

echo " > Removendo base de usuários anterior..."

rm usuario.unx

fi	

echo -n " > Processando arquivo .conf e criando banco de dados de usuários... "
echo -e $(cat usuario.conf)"@"$CODENOME"|root&ash.app# # Usuario da versao" >> usuario.unx
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

terminar 

}

init()
{

echo -e "Configurando script de inicialização..."

cd Dist/etc 

if [ -e init.unx ] ; then

echo " > Removendo script de inicialização anterior..."

rm init.unx

fi	

echo -n " > Processando arquivo .conf e criando script de inicialização... "
echo -e $(cat init.conf) >> init.unx
echo -e "[\e[32mOk\e[0m]"

cd ..
cd ..

terminar 

}

terminar()
{

echo -e "[\e[32mEtapa concluída com sucesso\e[0m]"

}

configurar(){

clear

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mSistema Operacional Hexagonix®\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       \e[1;94mTodos os direitos reservados\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                  \e[1;32mConfigurar ambiente de construção\e[0m        "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "Gerando configuração..."
echo

build
usuarios
init
host

echo -e "[\e[32mTudo pronto!\e[0m]"

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
*) configurar; exit;;

esac
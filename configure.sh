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
#;;              └──┘                             Versão 3.5.1
#;;
#;;
#;;************************************************************************************

checarDependencias()
{

echo -e "Verificando dependências necessárias à construção do sistema..."

# Agora vamos verificar cada dependência do mecanismo de construção

# Dependência 1

echo -n " > flat assembler "

if [ -e /usr/bin/fasm ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;31mVocê NÃO pode iniciar a construção do sistema sem essa dependência\e[0m."

fi	

# Dependência 2

echo -n " > qemu "

if [ -e /usr/bin/qemu-system-i386 ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;94mVocê pode iniciar a construção do sistema sem essa dependência\e[0m."

fi	

# Dependência 3

echo -n " > nasm "

if [ -e /usr/bin/nasm ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;94mVocê pode iniciar a construção do sistema sem essa dependência\e[0m."

fi	

# Dependência 4

echo -n " > dd "

if [ -e /usr/bin/dd ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;31mVocê NÃO pode iniciar a construção do sistema sem essa dependência\e[0m."

fi	

# Dependência 5

echo -n " > chown "

if [ -e /usr/bin/chown ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;94mVocê pode iniciar a construção do sistema sem essa dependência\e[0m."

fi	

# Dependência 6

echo -n " > cloc "

if [ -e /usr/bin/cloc ] ; then

echo -e "[\e[32mOk\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;94mVocê pode iniciar a construção do sistema sem essa dependência\e[0m."

fi	

terminar

# Agora vamos checar se os scripts estão disponíveis e torná-los executáveis

echo -e "Checando scripts e utilitários necessários à construção do sistema..."

# Script 1

echo -n " > Script de construção e execução do sistema (HX) "

if [ -e HX ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x HX

echo -e " [\e[94mExecutável\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;31mVocê NÃO pode iniciar a construção do sistema com essa dependência\e[0m."

fi	

# Script 2

echo -n " > Script de construção de utilitários externos (Externos.sh) "

if [ -e Externos/Externos.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Externos/Externos.sh 

echo -e " [\e[94mExecutável\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;31mVocê NÃO pode iniciar a construção do sistema com essa dependência\e[0m."

fi	

# Script 3

echo -n " > Script de construção de utilitários Unix (Unix.sh) "

if [ -e Apps/Unix/Unix.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Apps/Unix/Unix.sh 

echo -e " [\e[94mExecutável\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;31mVocê NÃO pode iniciar a construção do sistema com essa dependência\e[0m."

fi	

# Script 4

echo -n " > Script de construção de aplicativos Andromeda (Apps.sh) "

if [ -e Apps/Andromeda/Apps.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Apps/Andromeda/Apps.sh 

echo -e " [\e[94mExecutável\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;31mVocê NÃO pode iniciar a construção do sistema com essa dependência\e[0m."

fi	

# Script 5

echo -n " > Script de construção de fontes do Hexagonix (fontes.sh) "

if [ -e Fontes/fontes.sh ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x Fontes/fontes.sh 

echo -e " [\e[94mExecutável\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;31mVocê NÃO pode iniciar a construção do sistema com essa dependência\e[0m."

fi	

# Copiar HX

echo -n " > Copiando HX para /usr/bin... "

cp HX /usr/bin 

if [ -e /usr/bin/HX ] ; then

echo -en "[\e[32mOk\e[0m]"

chmod +x /usr/bin/HX

echo -e " [\e[94mExecutável\e[0m]"

else

echo -e "[\e[31mNão localizado\e[0m]"
echo -e "   > \e[1;31mVocê NÃO pode iniciar a construção do sistema com essa dependência\e[0m."

fi 

terminar 

}

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

limpar()
{

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
echo -e "Eliminando dependências instaladas em seu computador..."
echo
echo -n " > Removendo HX de /usr/bin... "

if [ -e /usr/bin/HX ] ; then

rm -rf /usr/bin/HX 

else

echo -e "[\e[94mPreviamente removido\e[0m] "

terminar 

exit

fi 

if [ -e /usr/bin/HX ] ; then

echo -en "[\e[1;31mFalha\e[0m]"

else

echo -en "[\e[32mOk\e[0m]"

echo -e " [\e[94mRemovido\e[0m]"

fi 

terminar 

}

configurar()
{

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
echo -e "Verificando dependências e definindo configurações de construção do sistema..."
echo

checarDependencias
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
limpar) limpar; exit;;
*) configurar; exit;;

esac
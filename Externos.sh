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

# Este arquivo constrói os utilitários e aplicativos de terceiros

# Primeiro, a versão mais atual do fasm

gerarExternos(){

echo -e "\e[1;94mConstruindo utilitários de terceiros para Hexagonix®...\e[0m {"
echo

cd fasmX/

cd SOURCE
cd HEXAGONIX 

for i in *.asm
do

	echo -en "Gerando aplicativo de terceiros \e[1;94m$(basename $i .asm)\e[0m..."
	
	fasm $i ../../../../$DIRETORIO/bin/`basename $i .asm` -d $BANDEIRAS >> /dev/null || echo " [Falha]"
	
    echo -e " [\e[32mOk\e[0m]"

done

cd ..
cd ..
cd ..

echo
echo -e "} [\e[32mUtilitários de terceiros construídos com sucesso\e[0m]."

}


export DIRETORIO=$1

gerarExternos
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

echo "Construindo utilitários de terceiros para Hexagonix®... {"
echo

cd fasmX/

cd SOURCE
cd HEXAGONIX 

for i in *.asm
do

	echo -n Gerando aplicativo de terceiros $(basename $i .asm).app...
	
	fasm $i ../../../../$DIRETORIO/`basename $i .asm`.app -d $BANDEIRAS >> /dev/null || echo " [Falha]"
	
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
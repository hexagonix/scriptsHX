#!/bin/sh
#;;************************************************************************************
#;;
#;;    
#;;        %#@@%&@@%&@@%@             Sistema Operacional Hexagonix®
#;;        #@@@@@@#@#@#@@
#;;        @#@@%    %#@#%
#;;        @#@@@    #@#@@
#;;        #@#@@    !@#@#     Copyright © 2016-2022 Felipe Miguel Nery Lunkes
#;;        @#@%!@&%@&@#@#             Todos os direitos reservados
#;;        !@@%#%&#&@&@%#
#;;        @@#!%&@&@#&*@&
#;;        @#@#%    &%@#@
#;;        @#!@@    !#@#@
#;;
#;;
#;;************************************************************************************

# Este arquivo constrói os utilitários e aplicativos de terceiros

# Primeiro, a versão mais atual do fasm

gerarExternos(){

cd fasm/

cd SOURCE
cd HEXAGONIX 

for i in *.asm
do

	echo -n Gerando aplicativo de terceiros $(basename $i .asm).app...
	
	fasm $i ../../../../$DIRETORIO/`basename $i .asm`.app -d $BANDEIRAS >> /dev/null || echo " [Falha]"
	
    echo "[Ok]"

done

cd ..
cd ..
cd ..

}

export DIRETORIO=$1

gerarExternos
#!/bin/bash
# Esse script deve ficar na raiz do projeto
# 
# Esse script foi adaptado para rodar sobre o Linux e versão do QEMU para Linux.
# Não funciona rodando nativamente sobre o WSL 2. Para isso, utilize 'WSL.sh'
#
#;;************************************************************************************
#;;
#;;    
#;;        %#@@%&@@%&@@%@             Sistema Operacional Andromeda®
#;;        #@@@@@@#@#@#@@
#;;        @#@@%    %#@#%
#;;        @#@@@    #@#@@
#;;        #@#@@    !@#@#     Copyright © 2016-2022 Felipe Miguel Nery Lunkes
#;;        @#@%!@&%@&@#@#             Todos os direitos reservados
#;;        !@@%#%&#&@&@%#
#;;        @@#!%&@&@#&*@&                       Versão 1.0
#;;        @#@#%    &%@#@
#;;        @#!@@    !#@#@
#;;
#;;
#;;************************************************************************************

# Primeiro, vamos montar a base 

cd Dist/etc

if [ -e base.ocl ] ; then

rm base.ocl

fi	

echo -e $(cat base.conf)$RANDOM">" >> base.ocl 

cd ..
cd ..

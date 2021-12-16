#!/bin/sh
#
# Esse script deve ficar na raiz do projeto
# 
# Esse script foi adaptado para rodar sobre o Windows Subsystem for Linux versão 2
# e utilizando a versão do QEMU para Windows 10. Não funciona rodando nativamente
# sobre o Linux. Para isso, utilize 'sistema.h'
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
#;;        @@#!%&@&@#&*@&
#;;        @#@#%    &%@#@
#;;        @#!@@    !#@#@
#;;
#;;
#;;************************************************************************************

construtor()
{
	
./sistema.sh

}

limpar(){
	
./sistema.sh limpar

rm -R Serial.txt
	
}

maquinaVirtual()
{
	
clear

echo ";;****************************************************************************"
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;        %#@@%&@@%&@@%@             Sistema Operacional Andromeda®          "
echo ";;        #@@@@@@#@#@#@@                                                     "
echo ";;        @#@@%    %#@#%                                                     "
echo ";;        @#@@@    #@#@@                                                     "
echo ";;        #@#@@    !@#@#     Copyright © 2016-2022 Felipe Miguel Nery Lunkes "
echo ";;        @#@%!@&%@&@#@#             Todos os direitos reservados            "
echo ";;        !@@%#%&#&@&@%#                                                     "
echo ";;        @@#!%&@&@#&*@&                                                     "
echo ";;        @#@#%    &%@#@                                                     "
echo ";;        @#!@@    !#@#@                                                     "
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;****************************************************************************"
echo
echo
echo "Iniciando máquina virtual com a imagem de sistema do Andromeda®"
echo 
echo "Usando as seguintes especificações:"
echo
echo "> Arquitetura: $sistema, Imagem: $imagem, Som: $drvsom"
echo "> Memoria: $memoria megabytes, Processador: $processador"
echo

sudo /mnt/c/Program\ Files/qemu/qemu-system-$sistema.exe -serial file:"Serial.txt" -hda $imagem -cpu $processador -m $memoria -soundhw $drvsom >> /dev/null || erroMV
	
}	

maquinaVirtualM()
{
	
clear

echo ";;****************************************************************************"
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;        %#@@%&@@%&@@%@             Sistema Operacional Andromeda®          "
echo ";;        #@@@@@@#@#@#@@                                                     "
echo ";;        @#@@%    %#@#%                                                     "
echo ";;        @#@@@    #@#@@                                                     "
echo ";;        #@#@@    !@#@#     Copyright © 2016-2022 Felipe Miguel Nery Lunkes "
echo ";;        @#@%!@&%@&@#@#             Todos os direitos reservados            "
echo ";;        !@@%#%&#&@&@%#                                                     "
echo ";;        @@#!%&@&@#&*@&                                                     "
echo ";;        @#@#%    &%@#@                                                     "
echo ";;        @#!@@    !#@#@                                                     "
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;****************************************************************************"
echo
echo
echo "Iniciando máquina virtual com a imagem de sistema do Andromeda®"
echo 
echo "Usando as seguintes especificações:"
echo
echo "> Arquitetura: $sistema, Imagem: $imagem, Som: $drvsom"
echo "> Memoria: $memoria megabytes, Processador: $processador"
echo

sudo /mnt/c/Program\ Files/qemu/qemu-system-$sistema.exe -serial file:"Serial.txt" -hda $imagem -cpu $processador -m $memoria >> /dev/null || erroMV
	
}	

maquinaVirtualS()
{
	
clear

echo ";;****************************************************************************"
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;        %#@@%&@@%&@@%@             Sistema Operacional Andromeda®          "
echo ";;        #@@@@@@#@#@#@@                                                     "
echo ";;        @#@@%    %#@#%                                                     "
echo ";;        @#@@@    #@#@@                                                     "
echo ";;        #@#@@    !@#@#     Copyright © 2016-2022 Felipe Miguel Nery Lunkes "
echo ";;        @#@%!@&%@&@#@#             Todos os direitos reservados            "
echo ";;        !@@%#%&#&@&@%#                                                     "
echo ";;        @@#!%&@&@#&*@&                                                     "
echo ";;        @#@#%    &%@#@                                                     "
echo ";;        @#!@@    !#@#@                                                     "
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;****************************************************************************"
echo
echo
echo "Iniciando máquina virtual com a imagem de sistema do Andromeda®"
echo 
echo "Usando as seguintes especificações:"
echo
echo "> Arquitetura: $sistema, Imagem: $imagem, Som: $drvsom"
echo "> Memoria: $memoria megabytes, Processador: $processador"
echo

sudo /mnt/c/Program\ Files/qemu/qemu-system-$sistema.exe -serial stdio -hda $imagem -cpu $processador -m $memoria >> /dev/null || erroMV
	
}	

maquinaVirtualHexagonix()
{

export imagem="Imagens/hexagonix.img"

clear

echo ";;****************************************************************************"
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;        %#@@%&@@%&@@%@             Sistema Operacional Hexagonix®          "
echo ";;        #@@@@@@#@#@#@@                                                     "
echo ";;        @#@@%    %#@#%                                                     "
echo ";;        @#@@@    #@#@@                                                     "
echo ";;        #@#@@    !@#@#     Copyright © 2016-2022 Felipe Miguel Nery Lunkes "
echo ";;        @#@%!@&%@&@#@#             Todos os direitos reservados            "
echo ";;        !@@%#%&#&@&@%#                                                     "
echo ";;        @@#!%&@&@#&*@&                                                     "
echo ";;        @#@#%    &%@#@                                                     "
echo ";;        @#!@@    !#@#@                                                     "
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;****************************************************************************"
echo
echo
echo "Iniciando máquina virtual com a imagem de sistema do Andromeda®"
echo 
echo "Usando as seguintes especificações:"
echo
echo "> Arquitetura: $sistema, Imagem: $imagem, Som: $drvsom"
echo "> Memoria: $memoria megabytes, Processador: $processador"
echo

sudo /mnt/c/Program\ Files/qemu/qemu-system-$sistema.exe -serial file:"Serial.txt" -hda $imagem -cpu $processador -m $memoria >> /dev/null || erroMV
	
}	

erroMV()
{
	
clear

echo ";;****************************************************************************"
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;        %#@@%&@@%&@@%@             Sistema Operacional Andromeda®          "
echo ";;        #@@@@@@#@#@#@@                                                     "
echo ";;        @#@@%    %#@#%                                                     "
echo ";;        @#@@@    #@#@@                                                     "
echo ";;        #@#@@    !@#@#     Copyright © 2016-2022 Felipe Miguel Nery Lunkes "
echo ";;        @#@%!@&%@&@#@#             Todos os direitos reservados            "
echo ";;        !@@%#%&#&@&@%#                                                     "
echo ";;        @@#!%&@&@#&*@&                                                     "
echo ";;        @#@#%    &%@#@                                                     "
echo ";;        @#!@@    !#@#@                                                     "
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;****************************************************************************"
echo
echo
echo "Um erro ocorreu ao iniciar a máquina virtual :("
echo
	
}

kernel()
{

./sistema.sh kernel

}

# Ponto de entrada do Script de construção de todo o Sistema, kernel e distribuição
#
# Primeiro, será testado se o usuário possui permissão de execução de superusuário
#
# Versão do script: 2.0
#
# Copyright (C) 2015-2022 Felipe Miguel Nery Lunkes
# Todos os direitos reservados

if test "`whoami`" != "root" ; then
	
clear

echo ";;****************************************************************************"
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;        %#@@%&@@%&@@%@             Sistema Operacional Andromeda®          "
echo ";;        #@@@@@@#@#@#@@                                                     "
echo ";;        @#@@%    %#@#%                                                     "
echo ";;        @#@@@    #@#@@                                                     "
echo ";;        #@#@@    !@#@#     Copyright © 2016-2022 Felipe Miguel Nery Lunkes "
echo ";;        @#@%!@&%@&@#@#             Todos os direitos reservados            "
echo ";;        !@@%#%&#&@&@%#                                                     "
echo ";;        @@#!%&@&@#&*@&                                                     "
echo ";;        @#@#%    &%@#@                                                     "
echo ";;        @#!@@    !#@#@                                                     "
echo ";;                                                                           "
echo ";;                                                                           "
echo ";;****************************************************************************"
echo
echo
echo "Para iniciar o processo solicitado, voce deve ser um superusuario ;D"
echo
echo "Voce deve logar como superusuario\nUtilize sudo $0.\n" && exit
	
fi

# Variáveis e constantes utilizados na montagem e no QEMU
	
export drvsom="pcspk"
export sistema="i386"
export imagem="Imagens/andromeda.img"
export processador="pentium3"
export memoria=32
export REG="log.log"

# Realizar a ação determinada pelo parâmetro fornecido

case $1 in

limpar) limpar; exit;;
mv) maquinaVirtual; exit;;
mvm) maquinaVirtualM; exit;;
hexagonix) maquinaVirtualHexagonix; exit;;
mvs) maquinaVirtualS; exit;;
kernel) kernel; exit;;
*) construtor; exit;;

esac 
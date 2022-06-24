#!/bin/bash
# Esse script deve ficar na raiz do projeto
# 
# Esse script foi adaptado para rodar sobre o Linux e versão do QEMU para Linux.
# Não funciona rodando nativamente sobre o WSL 2. Para isso, utilize 'WSL.sh'
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
#;;              └──┘                             Versão 3.0
#;;
#;;
#;;************************************************************************************

construtor()
{
	
./sistema.sh

}

limpar(){
	
./sistema.sh limpar
	
}

maquinaVirtual()
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
echo -e ";;              ┌─┘│                      \e[1;32mHX: iniciar máquina virtual\e[0m"
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "\e[1mIniciando máquina virtual com as seguintes especificações:\e[0m"
echo
echo -e "> Arquitetura de destino da imagem: \e[1;32m$sistema\e[0m"
echo -e "> Imagem de disco: \e[1;32m$imagem\e[0m"
echo -e "> Saída de som: \e[1;32m$drvsom\e[0m"
echo -e "> Memória: \e[1;32m$memoria megabytes\e[0m; processador: \e[1;32m$processador\e[0m"
echo

sudo qemu-system-$sistema -serial file:"Serial.txt" -hda $imagem -cpu $processador -m $memoria -soundhw $drvsom >> /dev/null || erroMV
	
}	

maquinaVirtualM()
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
echo -e ";;              ┌─┘│                      \e[1;32mHX: iniciar máquina virtual\e[0m"
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "\e[1mIniciando máquina virtual com as seguintes especificações:\e[0m"
echo
echo -e "> Arquitetura de destino da imagem: \e[1;32m$sistema\e[0m"
echo -e "> Imagem de disco: \e[1;32m$imagem\e[0m"
echo -e "> Saída de som: \e[1;32m$drvsom\e[0m"
echo -e "> Memória: \e[1;32m$memoria megabytes\e[0m; processador: \e[1;32m$processador\e[0m"
echo

sudo qemu-system-$sistema -serial file:"Serial.txt" -hda $imagem -cpu $processador -m $memoria >> /dev/null || erroMV
	
}	

maquinaVirtualS()
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
echo -e ";;              ┌─┘│                      \e[1;32mHX: iniciar máquina virtual\e[0m"
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "\e[1mIniciando máquina virtual com as seguintes especificações:\e[0m"
echo
echo -e "> Arquitetura de destino da imagem: \e[1;32m$sistema\e[0m"
echo -e "> Imagem de disco: \e[1;32m$imagem\e[0m"
echo -e "> Saída de som: \e[1;32m$drvsom\e[0m"
echo -e "> Memória: \e[1;32m$memoria megabytes\e[0m; processador: \e[1;32m$processador\e[0m"
echo

sudo qemu-system-$sistema -serial stdio -hda $imagem -cpu $processador -m $memoria >> /dev/null || erroMV
	
}	

maquinaVirtualHexagonix()
{

export imagem="hexagonix/hexagonix.img"

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
echo -e ";;              ┌─┘│                      \e[1;32mHX: iniciar máquina virtual\e[0m"
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "\e[1mIniciando máquina virtual com as seguintes especificações:\e[0m"
echo
echo -e "> Arquitetura de destino da imagem: \e[1;32m$sistema\e[0m"
echo -e "> Imagem de disco: \e[1;32m$imagem\e[0m"
echo -e "> Saída de som: \e[1;32m$drvsom\e[0m"
echo -e "> Memória: \e[1;32m$memoria megabytes\e[0m; processador: \e[1;32m$processador\e[0m"
echo

sudo qemu-system-$sistema -serial file:"Serial.txt" -hda $imagem -cpu $processador -m $memoria >> /dev/null || erroMV
	
}	

erroMV()
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
echo -e ";;              ┌─┘│                      \e[1;32mHX: iniciar máquina virtual\e[0m"
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "\e[1;31mUm erro ocorreu ao iniciar a máquina virtual.\e[0m"
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

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mSistema Operacional Hexagonix®\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       \e[1;94mTodos os direitos reservados\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                                                          "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo
echo -e "\e[1;31mPara iniciar o processo solicitado, voce deve ser um superusuario ;D\e[0m"
echo
echo -e "\e[1;32mVoce deve logar como superusuario\nUtilize sudo $0.\n\e[0m" && exit
	
fi

# Variáveis e constantes utilizados na montagem e no QEMU
	
export drvsom="pcspk"
export sistema="i386"
export imagem="hexagonix/andromeda.img"
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
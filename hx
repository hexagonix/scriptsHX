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
#;;              └──┘                            
#;;
#;;
#;;************************************************************************************

construtorAndromeda()
{

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="andromeda.img"

if [ "$IDIOMA" = "pt" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="andromeda.img"

elif [ "$IDIOMA" = "en" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=EN"
export imagemFinal="en.andromeda.img"

fi

export DESTINODISTRO="Andromeda"

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
echo -e ";;              ┌─┘│                  \e[1;32mConstruir o Hexagonix/Andromeda\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo
echo "Construindo o Sistema Operacional Andromeda® (Hexagonix base + utilitários)..."
echo

mkdir -p Andromeda

construirSaturno
construirHBoot
construirHexagon
construirUtilUnix
construirBaseAndromeda

cd Dist 

cd etc/

cp *.unx ../../Andromeda
cp base.ocl ../../Andromeda/andrmda.ocl
cp base.ocl ../../Andromeda/hexgnix.ocl

cd ..

cd man

cp *.man ../../Andromeda

cd ..
cd ..

cd Fontes/

if [ -e Atomic.asm ] ; then

echo -e "Existem fontes a serem construidas e copiadas... [\e[32mOk\e[0m]"

./fontes.sh

cp *.fnt ../Andromeda
rm *.fnt

echo
echo -n "Fontes copiadas"
echo -e " [\e[32mOk\e[0m]"
echo

else 

echo 
echo -e "Não existem fontes a serem construidas e copiadas... [\e[32mOk\e[0m]"
echo

fi

echo "Copiando principais bibliotecas de desenvolvimento..."
echo 

# Vamos copiar também o arquivo de cabeçalho para poder desenvolver sobre o Andromeda(R)

cd ..

cd lib/fasm

cp hexagon.s ../../Andromeda 

cd Estelar

cp estelar.s ../../../Andromeda

cd ..
cd ..

cd exemplo

cp * ../../Andromeda/

cd ..
cd ..

echo -n "Bibliotecas copiadas"
echo -e " [\e[32mOk\e[0m]"
echo

if [ -e Externos/Externos.sh ] ; then

cd Externos 

./Externos.sh Andromeda

cd ..

else 

echo "Não existem aplicativos de terceiros marcados para construção."
echo 

fi 

cd Dist 

echo
echo "Visualize o arquivo de log 'log.log', para mais informações da montagem."
echo

cd ..

}

construtorHexagonix()
{

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=UNIX -d VERBOSE=SIM -d IDIOMA=PT"

if [ "$IDIOMA" = "pt" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=UNIX -d VERBOSE=SIM -d IDIOMA=PT"

elif [ "$IDIOMA" = "en" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=UNIX -d VERBOSE=SIM -d IDIOMA=EN"

fi

export DESTINODISTRO="Hexagonix"
export ALVODISTRO="hexagonix"

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
echo -e ";;              ┌─┘│                       \e[1;32mConstruir o Hexagonix\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo
echo "Construindo o Sistema Operacional Hexagonix®..."
echo

mkdir -p Hexagonix

construirSaturno
construirHBoot
construirHexagon
construirUtilUnix

cd ..

cd Dist 

cd etc/

cp *.unx ../../Hexagonix
cp base.ocl ../../Hexagonix/hexgnix.ocl

cd ..

cd man

cp *.man ../../Hexagonix

cd ..
cd ..

cd Fontes/

if [ -e Atomic.asm ] ; then

echo -e "Existem fontes a serem construidas e copiadas... [\e[32mOk\e[0m]"

./fontes.sh

cp *.fnt ../Hexagonix
rm *.fnt

echo
echo -n "Fontes copiadas"
echo -e " [\e[32mOk\e[0m]"
echo

else 

echo 
echo -n "Não existem fontes a serem construidas e copiadas..."
echo -e " [\e[32mOk\e[0m]"
echo

fi

cd ..

echo "Copiando principais bibliotecas de desenvolvimento..."
echo 

# Vamos copiar também o arquivo de cabeçalho para poder desenvolver sobre o Andromeda(R)

cd lib/fasm

cp hexagon.s ../../Hexagonix/

cd ..

cd exemplo

cp tapp.asm ../../Hexagonix

cd ..
cd ..

echo -n "Bibliotecas copiadas"
echo -e " [\e[32mOk\e[0m]"
echo

if [ -e Externos/Externos.sh ] ; then

cd Externos 

./Externos.sh Hexagonix

cd ..

else 

echo "Não existem aplicativos de terceiros marcados para construção."
echo 

fi 

cd Dist 

echo 
echo "Visualize o arquivo de log 'log.log', para mais informações da montagem."
echo

cd ..

}

erroConstrucao(){
	
echo "Um erro ocorreu durante a construção de algum componente do sistema."
echo 
echo "Verifique o status dos componentes e utilize as saídas de erro acima para verificar o problema."
echo 
echo "Visualize o arquivo de log 'log.log', para mais informações sobre o(s) erro(s)."
echo 

umount Sistema/ >> /dev/null
umount Andromeda/ >> /dev/null

exit	

}

limpar(){
	
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
echo -e ";;              ┌─┘│                      \e[1;32mLimpar árvore do sistema\e[0m"
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo "Executando limpeza na árvore do sistema..."
echo -n " > Limpando componentes gerados e imagens do sistema..."
	
rm -rf Sistema Andromeda Hexagonix andromeda.img hexagonix.img
rm -rf log.log COM1.txt *.sis *.bin *.app Serial.txt 

echo -e " [\e[32mOk\e[0m]"
echo -e "   > \e[1;94mUse ./hx com parâmetros para gerar estes arquivos novamente.\e[0m"
echo " > Para ajuda nos parâmetros possíveis, use ./hx ajuda."
echo -n " > Removendo arquivos de configuração gerados a cada build..."

rm -rf Dist/etc/*.unx Dist/etc/*.ocl

echo -e " [\e[32mOk\e[0m]"
echo -e "   > \e[1;94mUse ./configure.sh para gerar estes arquivos novamente.\e[0m"

tudopronto

echo
		
}

maquinaVirtual()
{

if [ -e $imagem ] ; then

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

else

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
echo -e "Erro na solicitação: \e[1;94mimagem de disco '$imagem' não localizada\e[0m."
echo -e " > \e[1;31mVocê NÃO pode iniciar o sistema sem essa dependência\e[0m."
echo

fi	
	
}	

maquinaVirtualM()
{

if [ -e $imagem ] ; then

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

else

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
echo -e "Erro na solicitação: \e[1;94mimagem de disco '$imagem' não localizada\e[0m."
echo -e " > \e[1;31mVocê NÃO pode iniciar o sistema sem essa dependência\e[0m."
echo

fi	

}	

maquinaVirtualHexagonixKVM()
{

export imagem="hexagonix/hexagonix.img"

if [ -e $imagem ] ; then

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
echo -e "> Arquitetura de destino da imagem: \e[1;32m$sistema\e[0m; Usando KVM!"
echo -e "> Imagem de disco: \e[1;32m$imagem\e[0m"
echo -e "> Saída de som: \e[1;32m$drvsom\e[0m"
echo -e "> Memória: \e[1;32m$memoria megabytes\e[0m; processador: \e[1;32mhost\e[0m"
echo

sudo qemu-system-$sistema --enable-kvm -serial file:"Serial.txt" -cpu host -hda $imagem -m $memoria >> /dev/null || erroMV

else

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
echo -e "Erro na solicitação: \e[1;94mimagem de disco '$imagem' não localizada\e[0m."
echo -e " > \e[1;31mVocê NÃO pode iniciar o sistema sem essa dependência\e[0m."
echo

fi	

}	

maquinaVirtualAndromedaKVM()
{

if [ -e $imagem ] ; then

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
echo -e "> Arquitetura de destino da imagem: \e[1;32m$sistema\e[0m; Usando KVM!"
echo -e "> Imagem de disco: \e[1;32m$imagem\e[0m"
echo -e "> Saída de som: \e[1;32m$drvsom\e[0m"
echo -e "> Memória: \e[1;32m$memoria megabytes\e[0m; processador: \e[1;32mhost\e[0m"
echo

sudo qemu-system-$sistema --enable-kvm -serial file:"Serial.txt" -cpu host -hda $imagem -m $memoria >> /dev/null || erroMV

else

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
echo -e "Erro na solicitação: \e[1;94mimagem de disco '$imagem' não localizada\e[0m."
echo -e " > \e[1;31mVocê NÃO pode iniciar o sistema sem essa dependência\e[0m."
echo

fi	

}	

maquinaVirtualS()
{

if [ -e $imagem ] ; then

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

else

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
echo -e "Erro na solicitação: \e[1;94mimagem de disco '$imagem' não localizada\e[0m."
echo -e " > \e[1;31mVocê NÃO pode iniciar o sistema sem essa dependência\e[0m."
echo

fi	
	
}	

maquinaVirtualHexagonix()
{

export imagem="hexagonix/hexagonix.img"

if [ -e $imagem ] ; then

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

else

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
echo -e "Erro na solicitação: \e[1;94mimagem de disco '$imagem' não localizada\e[0m."
echo -e " > \e[1;31mVocê NÃO pode iniciar o sistema sem essa dependência\e[0m."
echo

fi	
		
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
echo -e "Erro na solicitação: \e[1;94mproblema durante a execução da máquina virtual\e[0m."
echo -e " > \e[1;31mTente executar a máquina virtual novamente\e[0m."
echo
	
}

infoBuild(){

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
echo -e ";;              ┌─┘│                        \e[1;32mInformações do sistema\e[0m"
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "Veja agora algumas informações e definições da construção \e[1matual\e[0m do sistema:"
echo -e " > Versão do Hexagonix base: \e[1;32m$VERSAO\e[0m"
echo -e " > Revisão do software: \e[1;32m$REVISAO\e[0m"
echo -e " > Nome do lançamento: \e[1;32m$CODENOME\e[0m"
echo
echo ";;****************************************************************************"
echo 

}

kernel()
{

kernel

}

prepDistros(){

iniciarLog

# Aqui iremos construir as imagens do Andromeda e do Hexagonix ao mesmo tempo

definirHexagonix
imagemHexagonix

definirAndromedaOficial
imagemAndromeda

}

prepImagemHexagonix(){

iniciarLog

definirHexagonix
imagemHexagonix

}

prepImagemAndromeda(){

iniciarLog

definirAndromedaOficial
imagemAndromeda

}

prepImagemAndromedaTeste(){

iniciarLog

definirAndromedaTeste
imagemAndromeda

}

# Porção de código responsável por gerar a imagem do sistema
#
# Incluído a partir do script imagem.sh

definirHexagonix()
{

export LOG="log.log"
export IMG="hexagonix.img"
export TAMANHOIMAGEM=2097012
export TAMANHOTEMP=2048	

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=UNIX -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="hexagonix.img"
export Par="pt"

if [ "$PT2" = "pt" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=UNIX -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="hexagonix.img"
export Par="pt"

elif [ "$PT2" = "en" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=UNIX -d VERBOSE=SIM -d IDIOMA=EN"
export imagemFinal="en.hexagonix.img"
export Par="en"

fi

}

definirAndromedaTeste()
{

# Aqui vamos gerar uma imagem pequena, de 2 Mb, menor e apenas para testes. Essa imagem
# não deve ser utilizada para o pacote de instalação.

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="andromeda.img"
export Par="pt"

if [ "$PT2" = "pt" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="andromeda.img"
export Par="pt"

elif [ "$PT2" = "en" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=EN"
export imagemFinal="en.andromeda.img"
export Par="en"

fi

export LOG="log.log"
export IMG="andromeda.img"
export TAMANHOIMAGEM=2097012
export TAMANHOTEMP=2048	

}

definirAndromedaOficial()
{

# Aqui vamos definir uma imagem de tamanho oficial, que demora mais a ser gerada. Essa imagem é
# apropriada para o pacote de instalação do Andromeda®

export LOG="log.log"
export IMG="andromeda.img"
export TAMANHOIMAGEM=47185920
export TAMANHOTEMP=92160	

}

definirVerbose()
{

# Aqui vamos definir se mensagens de erro deverão aparecer no processo de montagem

case $PT2 in

hexagonix) definirHexagonix; exit;;
andromeda) definirAndromedaTeste; exit;;
oficial) definirAndromedaOficial; exit;;
*) definirAndromedaTeste; exit;;

esac

}

imagemHexagonix()
{

if test "`whoami`" != "root" ; then

sureq

exit

fi

definirHexagonix

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
echo -e ";;              ┌─┘│                       \e[1;32mConstruir o Hexagonix\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo "Construindo o Hexagonix®..."
echo

# Agora os arquivos do Sistema serão gerados...

construtorHexagonix $PT2

# Agora a imagem do Sistema será preparada...

echo -e "\e[1;94mConstruindo imagem do sistema...\e[0m"
echo

echo "Construindo imagem temporária para manipulação de arquivos......" >> $LOG

dd status=none bs=512 count=$TAMANHOTEMP if=/dev/zero of=temp.img >> $LOG || erroMontagem

if [ ! -e hexagonix.img ] ; then

echo >> $LOG
echo "Construindo imagem que receberá os arquivos do sistema..." >> $LOG
echo >> $LOG

dd status=none bs=$TAMANHOIMAGEM count=1 if=/dev/zero of=$IMG >> $LOG || erroMontagem
	
fi	

echo "> Copiando carregador de inicialização para a imagem..." >> $LOG

dd status=none conv=notrunc if=Hexagonix/saturno.img of=temp.img >> $LOG || erroMontagem

echo "> Montando a imagem..." >> $LOG
 
mkdir -p Sistema && mount -o loop -t vfat temp.img Sistema/ || erroMontagem

echo "> Copiando arquivos do sistema para a imagem..." >> $LOG
echo >> $LOG

cp Hexagonix/*.man Sistema/ >> $LOG || erroMontagem

if [ -e Hexagonix/*.asm ] ; then

cp Hexagonix/*.asm Sistema/ >> $LOG

fi	

cp Hexagonix/*.s Sistema/ >> $LOG
cp Hexagonix/*.cow Sistema/ >> $LOG || erroMontagem
cp Hexagonix/*.app Sistema/ >> $LOG || erroMontagem
cp Hexagonix/*.asm Sistema/ >> $LOG
cp Hexagonix/hboot Sistema/ >> $LOG || erroMontagem

if [ -e Hexagonix/Spartan.mod ] ; then

cp Hexagonix/*.mod Sistema/ >> $LOG

fi	

cp Hexagonix/*.sis Sistema/ >> $LOG || erroMontagem
cp Hexagonix/*.unx Sistema/ >> $LOG || erroMontagem
cp Hexagonix/*.ocl Sistema/ >> $LOG || erroMontagem

# Até o momento, nenhum banco de dados utilizado em aplicativos Andromeda® precisam ser copiados
# para uma imagem Hexagonix® pura.

# cp Hexagonix/*.ocl Sistema/ >> $LOG || erroMontagem

# Caso a imagem deva conter uma cópia dos arquivos do FreeDOS para testes...

if [ -e DOS ] ; then

cp DOS/*.* Sistema/

fi	

# Agora será verificado se alguma fonte deverá ser incluída na imagem
#
# Se o arquivo de fonte padrão estiver disponível, usar essa informação como interruptor
# para ligar a cópia

echo >> $LOG
echo -n "> Verificando se existem fontes para copiar..." >> $LOG

if [ -e Hexagonix/Atomic.fnt ] ; then

echo " [Sim]" >> $LOG

cp Hexagonix/*.fnt Sistema/ || erroMontagem
	
fi	

if [ ! -e Hexagonix/Atomic.fnt ] ; then

echo " [Não]" >> $LOG
	
fi	

echo >> $LOG

sleep 1.0 || erroMontagem

echo "> Desmontando imagem..." >> $LOG

umount Sistema >> /dev/null || erroMontagem

echo "> Montando imagem final..." >> $LOG

echo "  * Copiando imagem temporária para a imagem final..." >> $LOG

dd status=none conv=notrunc if=temp.img of=$IMG seek=1 >> $LOG || erroMontagem 

echo "  * Copiando MBR e tabela de partição para a imagem e finalizando-a..." >> $LOG

dd status=none conv=notrunc if=Hexagonix/mbr.img of=$IMG >> $LOG || erroMontagem

echo "> Removendo arquivos e pastas temporárias, além de binários que não são mais necessários..." >> $LOG
echo >> $LOG

rm -rf Sistema Hexagonix temp.img >> $LOG

if test $VERBOSE -e 0; then

clear

elif test $VERBOSE -e 1; then

echo 

fi

mv hexagonix.img $dirImagem/$imagemFinal

qemu-img convert -O vdi $dirImagem/$imagemFinal $dirImagem/$(basename $imagemFinal .img).vdi 

# Vamos agora trocar a propriedade da imagem para um usuário comum

chown $dirImagem/$imagemFinal --reference=$dirImagem/README.md
chown $dirImagem/$(basename $imagemFinal .img).vdi --reference=$dirImagem/README.md

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mSistema Operacional Hexagonix®\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       \e[1;94mTodos os direitos reservados\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                       \e[1;32mConstruir o Hexagonix\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "\e[32mSucesso ao construir o sistema e a imagem de disco.\e[0m"
echo
echo -e "Veja agora algumas informações da construção \e[1matual\e[0m do sistema:"
echo -e " > Versão do Hexagonix base: \e[1;32m$VERSAO\e[0m"
echo -e " > Revisão do software: \e[1;32m$REVISAO\e[0m"
echo -e " > Nome do lançamento: \e[1;32m$CODENOME\e[0m"
echo -e " > Localização da imagem: \e[1;32m$dirImagem/$imagemFinal\e[0m"
echo
echo ";;****************************************************************************"
echo

echo "> Imagem '$IMG' gerada com sucesso." >> $LOG
echo >> $LOG
echo "Utilize './hx mv.HX' para testar a execução do sistema na imagem gerada ou copie" >> $LOG
echo "a imagem para o diretório 'Inst' da raiz do instalador para gerar uma imagem de instalação" >> $LOG
echo "baseada em Linux para transferência para um disco." >> $LOG
echo >> $LOG
echo "----------------------------------------------------------------------" >> $LOG
echo >> $LOG

}

erroMontagem()
{

if test $VERBOSE -e 0; then

clear

elif test $VERBOSE -e 1; then

echo 

fi

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mSistema Operacional Hexagonix®\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       \e[1;94mTodos os direitos reservados\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                       \e[1;31mErro na construção do sistema\e[0m"
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo
echo -e "\e[1;31mAlgo de errado ocorreu durante a montagem da imagem :(\e[0m"
echo
echo "Utilize o script de geração do Sistema para verificar a origem do problema."
echo

umount Sistema/ >> /dev/null
umount Andromeda/ >> /dev/null

exit
	
}

imagemAndromeda()
{

if test "`whoami`" != "root" ; then

sureq

exit

fi

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
echo -e ";;              ┌─┘│                  \e[1;32mConstruir o Hexagonix/Andromeda\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo "Construindo o Hexagonix/Andromeda..."
echo

# Agora os arquivos do Sistema serão gerados...

construtorAndromeda $Par

# Agora a imagem do Sistema será preparada...

echo -e "\e[1;94mConstruindo imagem do sistema...\e[0m"
echo

echo "Construindo imagem temporária para manipulação de arquivos......" >> $LOG

dd status=none bs=512 count=$TAMANHOTEMP if=/dev/zero of=temp.img >> $LOG || erroMontagem

if [ ! -e andromeda.img ] ; then

echo >> $LOG
echo "Construindo imagem que receberá os arquivos do sistema..." >> $LOG
echo >> $LOG

dd status=none bs=$TAMANHOIMAGEM count=1 if=/dev/zero of=$IMG >> $LOG || erroMontagem
	
fi	

echo "> Copiando carregador de inicialização para a imagem..." >> $LOG

dd status=none conv=notrunc if=Andromeda/saturno.img of=temp.img >> $LOG || erroMontagem

echo "> Montando a imagem..." >> $LOG
 
mkdir -p Sistema && mount -o loop -t vfat temp.img Sistema/ || erroMontagem

echo "> Copiando arquivos do sistema para a imagem..." >> $LOG
echo >> $LOG

cp Andromeda/*.man Sistema/ >> $LOG || erroMontagem
cp Andromeda/*.asm Sistema/ >> $LOG
cp Andromeda/*.s Sistema/ >> $LOG
cp Andromeda/*.cow Sistema/ >> $LOG || erroMontagem
cp Andromeda/*.app Sistema/ >> $LOG || erroMontagem
cp Andromeda/hboot Sistema/ >> $LOG || erroMontagem

if [ -e Andromeda/Spartan.mod ] ; then

cp Andromeda/*.mod Sistema/ >> $LOG

fi	

cp Andromeda/*.sis Sistema/ >> $LOG || erroMontagem
cp Andromeda/*.unx Sistema/ >> $LOG || erroMontagem
cp Andromeda/*.ocl Sistema/ >> $LOG || erroMontagem

# Caso a imagem deva conter uma cópia dos arquivos do FreeDOS para testes...

if [ -e DOS ] ; then

cp DOS/*.* Sistema/

fi	

# Agora será verificado se alguma fonte deverá ser incluída na imagem
#
# Se o arquivo de fonte padrão estiver disponível, usar essa informação como interruptor
# para ligar a cópia

echo >> $LOG
echo -n "> Verificando se existem fontes para copiar..." >> $LOG

if [ -e Andromeda/Atomic.fnt ] ; then

echo " [Sim]" >> $LOG

cp Andromeda/*.fnt Sistema/ || erroMontagem
	
fi	

if [ ! -e Andromeda/Atomic.fnt ] ; then

echo " [Não]" >> $LOG
	
fi	

echo >> $LOG

sleep 1.0 || erroMontagem

echo "> Desmontando imagem..." >> $LOG

umount Sistema >> /dev/null || erroMontagem

echo "> Montando imagem final..." >> $LOG

echo "  * Copiando imagem temporária para a imagem final..." >> $LOG

dd status=none conv=notrunc if=temp.img of=$IMG seek=1 >> $LOG || erroMontagem 

echo "  * Copiando MBR e tabela de partição para a imagem e finalizando-a..." >> $LOG

dd status=none conv=notrunc if=Andromeda/mbr.img of=$IMG >> $LOG || erroMontagem

echo "> Removendo arquivos e pastas temporárias, além de binários que não são mais necessários..." >> $LOG
echo >> $LOG

rm -rf Sistema Andromeda temp.img >> $LOG

if test $VERBOSE -e 0; then

clear

elif test $VERBOSE -e 1; then

echo 

fi

mv andromeda.img $dirImagem/$imagemFinal

qemu-img convert -O vdi $dirImagem/$imagemFinal $dirImagem/$(basename $imagemFinal .img).vdi 

# Vamos agora trocar a propriedade da imagem para um usuário comum

chown $dirImagem/$imagemFinal --reference=$dirImagem/README.md
chown $dirImagem/$(basename $imagemFinal .img).vdi --reference=$dirImagem/README.md

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mSistema Operacional Hexagonix®\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       \e[1;94mTodos os direitos reservados\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                  \e[1;32mConstruir o Hexagonix/Andromeda\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "\e[32mSucesso ao construir o sistema e a imagem de disco.\e[0m"
echo
echo -e "Veja agora algumas informações da construção \e[1matual\e[0m do sistema:"
echo -e " > Versão do Hexagonix base: \e[1;32m$VERSAO\e[0m"
echo -e " > Revisão do software: \e[1;32m$REVISAO\e[0m"
echo -e " > Nome do lançamento: \e[1;32m$CODENOME\e[0m"
echo -e " > Localização da imagem: \e[1;32m$dirImagem/$imagemFinal\e[0m"
echo
echo ";;****************************************************************************"
echo

echo "> Imagem '$IMG' gerada com sucesso." >> $LOG
echo >> $LOG
echo "Utilize './hx mv.ANDROMEDA' para testar a execução do sistema na imagem gerada ou copie" >> $LOG
echo "a imagem para o diretório 'Inst' da raiz do instalador para gerar uma imagem de instalação" >> $LOG
echo "baseada em Linux para transferência para um disco." >> $LOG
echo >> $LOG
echo "----------------------------------------------------------------------" >> $LOG
echo >> $LOG

exit

}

executarConfigure()
{

clear

if [ -e configure.sh ] ; then

echo
echo -e "[\e[32mPermitindo execução e iniciando configure.sh...\e[0m]"

# Primeiro, ter certeza que o arquivo pode ser executado

chmod +x configure.sh

./configure.sh 

else

echo -e "[\e[31mErro: configure.sh não localizado\e[0m]"
echo -e " > \e[1;31mVocê NÃO pode iniciar a construção do sistema sem essa dependência\e[0m."

fi	

terminar
tudopronto

}

terminar()
{

echo -e "[\e[32mEtapa concluída com sucesso\e[0m]"

}

tudopronto(){

echo -e "[\e[32mTudo pronto!\e[0m]"

}

exibirEstatisticas(){

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
echo -e ";;              ┌─┘│                            \e[1;32mEstatísticas\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************" 

if [ -e /usr/bin/cloc ] ; then

for i in */
do

	echo
	echo -en "\e[1;94mEstatísticas do diretório $i:\e[0m"
	echo 
	echo

	cloc $i

	terminar

done

tudopronto 

else

echo
echo -e "[\e[1;31mUtilitário cloc não localizado.\e[0m]"
echo -e "\e[1;94mO HX não pode gerar relatório de estatísticas sem essa dependência.\e[0m"

fi	

echo

}

exibirAjuda() {

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
echo -e ";;              ┌─┘│                            \e[1;32mAjuda do HX\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "Parâmetros \e[1;94mprincipais\e[0m disponíveis:"
echo 
echo -e "\e[1;32mmv.HX\e[0m - Iniciar máquina virtual com o Hexagonix com KVM"
echo -e "\e[1;32mmv.HX.SEMKVM\e[0m - Iniciar máquina virtual com o Hexagonix sem KVM"
echo -e "\e[1;32mmv.ANDROMEDA\e[0m - Iniciar máquina virtual com o Hexagonix/Andromeda com KVM"
echo -e "\e[1;32mmv.ANDROMEDA.SEMKVM\e[0m - Iniciar máquina virtual com o Hexagonix/Andromeda sem KVM"
echo -e "\e[1;32mmv.ANDROMEDA.SOM\e[0m - Iniciar máquina virtual com o Andromeda em modo com som"
echo -e "\e[1;32mmv.ANDROMEDA.SERIAL\e[0m - Iniciar máquina virtual com o Andromeda sem saída serial"
echo -e "\e[1;32mimg.HX\e[0m - Construir imagem de disco com o Hexagonix"
echo -e "\e[1;32mimg.ANDROMEDA\e[0m - Construir imagem de disco com o Hexagonix/Andromeda"
echo -e "\e[1;32mimg.ANDROMEDA.TESTE\e[0m - Construir imagem de disco teste com o Hexagonix/Andromeda"
echo -e "\e[1;32mimg.DISTROS\e[0m - Construir imagem de disco com o Hexagonix e com o Andromeda"
echo -e "\e[1;32mlimpar\e[0m - Limpa os arquivos de configuração e binários da árvore do sistema"

echo 

}

exibirCopyright() {

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
echo -e ";;              ┌─┘│                            \e[1;32mCopyright\e[0m "
echo -e ";;              └──┘                          \e[1;32mHX versão $VERSAOHX\e[0m"
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "\e[1;94mHX: Ferramenta de construção e testes do Hexagonix® e Andromeda®\e[0m"
echo
echo -e "Desenvolvido por \e[1;32mFelipe Miguel Nery Lunkes\e[0m"
echo 
echo -e "\e[1;32mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e "\e[1;32mTodos os direitos reservados.\e[0m"
echo

}

parametrosNecessarios(){

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
echo -e ";;              ┌─┘│                            \e[1;32mAjuda do HX\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "Você precisa fornecer pelo menos um parâmetro para o HX."
echo 
echo -e "\e[1;94mDica: utilize \e[1;32m./hx ajuda \e[1;94mou \e[1;32m$NOMEHX ajuda\e[1;94m para obter os parâmetros disponíveis.\e[0m"
echo

}

iniciarLog()
{

if [ -e $REG ] ; then

rm -r $REG
	
fi	

# Montar o cabeçalho do arquivo de log...

echo "Relatório de montagem e estatísticas do Sistema Operacional Andromeda®" >> $REG
echo "----------------------------------------------------------------------" >> $REG
echo >> $REG
echo "Neste arquivo você poderá encontrar dados e informações de montagem" >> $REG
echo "dos arquivos do Sistema, podendo entre outras coisas identificar erros" >> $REG
echo "no processo." >> $REG
echo >> $REG
echo -n "Data e hora deste relatório: " >> $REG
date >> $REG
echo >> $REG
echo -n "Usuario atualmente logado: " >> $REG
whoami >> $REG
echo >> $REG
echo "----------------------------------------------------------------------" >> $REG
echo >> $REG

}

# Vamos separar aqui as etapas comuns de construção do sistema para reutilizar
# código e facilitar a busca de erros

construirHexagon(){

cd Hexagon

echo
echo -en "\e[1;94mConstruindo o Kernel Hexagon®...\e[0m"

echo "Kernel Hexagon®..." >> ../log.log
echo >> ../log.log

fasm Hexagon.asm Hexagon.sis -d $BANDEIRASHEXAGON >> ../log.log || erroConstrucao

cp Hexagon.sis ../$DESTINODISTRO

rm -r Hexagon.sis

echo -e " [\e[32mOk\e[0m]"

echo >> ../log.log
echo "Kernel Hexagon® construído com sucesso." >> ../log.log
echo >> ../log.log
echo "----------------------------------------------------------------------" >> ../log.log
echo >> ../log.log

cd ..

}

construirSaturno(){

echo -e "\e[1;94mComponentes de inicialização do Hexagon®...\e[0m {"
echo

echo "Componentes de inicialização do Hexagon®... {" >> $REG
echo >> $REG

echo -e "\e[1;94mCarregador de inicialização do Hexagon® - Saturno® (1º estágio)...\e[0m"
echo

echo "Carregador de inicialização do Hexagon® - Saturno® (1º estágio)..." >> $REG
echo >> $REG

cd Boot

cd Saturno

fasm saturno.asm ../saturno.img >> ../../log.log || erroConstrucao

echo >> ../../log.log

fasm mbr.asm ../mbr.img >> ../../log.log || erroConstrucao

echo >> ../../log.log

cd ..


}

construirHBoot(){


echo -e "\e[1;94mHexagon Boot - HBoot (2º estágio)...\e[0m"
echo

echo "Hexagon Boot - HBoot (2º estágio)..." >> ../log.log
echo >> ../log.log

cd "Hexagon Boot"

fasm hboot.asm ../hboot -d $BANDEIRASHBOOT >> ../../log.log || erroConstrucao

cd Mods

if [ -e Spartan.asm ] ; then

for i in *.asm
do

	echo -en "Construindo módulo compatível com HBoot® \e[1;94m$(basename $i .asm).mod\e[0m..."
	
	fasm $i ../../`basename $i .asm`.mod -d $BANDEIRAS >> ../../../log.log 
	
	echo -e " [\e[32mOk\e[0m]"
	
done

fi

cd ..

cd ..

cp *.img ../$DESTINODISTRO
cp hboot ../$DESTINODISTRO

if [ -e Spartan.mod ] ; then

cp *.mod ../$DESTINODISTRO/ 
rm -r *.mod 

fi	

rm -r *.img
rm -r hboot

echo
echo -e "} [\e[32mComponentes de inicialização construídos com sucesso\e[0m]."

echo >> ../log.log
echo "} Componentes de inicialização do Hexagon® construídos com sucesso." >> ../log.log
echo >> ../log.log
echo "----------------------------------------------------------------------" >> ../log.log
echo >> ../log.log

cd ..

}

construirUtilUnix(){

# Gerar os aplicativos base Unix

cd Apps/Unix

./Unix.sh $ALVODISTRO

cd ..

cp *.app ../$DESTINODISTRO
rm *.app

}

construirBaseAndromeda(){

cd Andromeda
	
./Apps.sh

cd ..

cp *.app ../$DESTINODISTRO
rm *.app

cd ..

}

instalarDependencias(){

if test "`whoami`" != "root" ; then

sureq

exit

fi

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mSistema Operacional Hexagonix®\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       \e[1;94mTodos os direitos reservados\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                        \e[1;32mInstalar dependências\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "O HX irá agora instalar as dependências necessárias à sua execução:"
echo

apt install fasm nasm cloc qemu qemu-system-i386

terminar 

echo
echo -e "\e[1mPronto! Agora execute \e[32m./configure.sh\e[0;1m para configurar as dependências."

tudopronto

echo 

}

sureq()
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
echo -e ";;              ┌─┘│              \e[1;32mHX: Você precisa ser root para continuar\e[0m"
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo
echo -e "\e[1;94mPara executar a ação solicitada, você deve ser um usuário raiz (root) ;D\e[0m"
echo
echo -e "\e[1;32mInsira sua senha abaixo para alterar para o usuário raiz (root) e depois\e[0m"
echo -e "\e[1;32mexecute o HX novamente, com os parâmetros desejados.\e[0m"
echo
echo -e "\e[1;94mDica: utilize \e[1;32m./hx ajuda\e[1;94m para obter os parâmetros disponíveis.\e[0m"
echo

su root

exit 

} 

# Ponto de entrada do Script de construção de todo o Sistema, kernel e distribuição
#
# Primeiro, será testado se o usuário possui permissão de execução de superusuário
#
# Copyright (C) 2015-2022 Felipe Miguel Nery Lunkes
# Todos os direitos reservados

# Variáveis e constantes utilizados na montagem e no QEMU
	
export drvsom="pcspk"
export sistema="i386"
export imagem="hexagonix/andromeda.img"
export processador="pentium3"
export memoria=32
export REG="log.log"
export REVISAO=$(cat Dist/etc/revisao.def)
export CODENOME=$(cat Dist/etc/codenome.def)
export VERSAO=$(cat Dist/etc/versao.def)
export NOMEHX=$0
export PT2=$2
export PT3=$3
export PT4=$4
export PT5=$5
export dirImagem="hexagonix"
export VERSAOHX="8.0"

# Agora vamos exportar flags (bandeiras) para as etapas de montagem e/ou compilação

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export BANDEIRASHEXAGON="VERBOSE=SIM"
export BANDEIRASHBOOT="TEMATOM=ANDROMEDA"
export IDIOMA=$2

# Agora, vamos definir onde estão os cabeçalhos e bibliotecas

export INCLUDE="$(pwd)/lib/fasm"

# Realizar a ação determinada pelo parâmetro fornecido

case $1 in

# Funções para criar imagens de disco e iniciar máquinas virtuais

mv.HX) maquinaVirtualHexagonixKVM; exit;;
mv.HX.SEMKVM) maquinaVirtualHexagonix; exit;;
mv.ANDROMEDA) maquinaVirtualAndromedaKVM; exit;;
mv.ANDROMEDA.SOM) maquinaVirtual; exit;;
mv.ANDROMEDA.SERIAL) maquinaVirtualS; exit;;
mv.ANDROMEDA.SEMKVM) maquinaVirtualAndromedaM; exit;;
img.HX) prepImagemHexagonix; exit;;
img.ANDROMEDA) prepImagemAndromeda; exit;;
img.ANDROMEDA.TESTE) prepImagemAndromedaTeste; exit;;
img.DISTROS) prepDistros; exit;;

# Funções de ajuda e utilidades

ajuda) exibirAjuda; exit;;
estat) exibirEstatisticas; exit;;
info) infoBuild; exit;;
copyright) exibirCopyright; exit;;
versao) exibirCopyright; exit;;
depend) instalarDependencias; exit;;

# Agora funções de construção e limpeza

b.Hexagon) construirHexagon; exit;;
b.HBoot) construirHBoot; exit;;
b.Saturno) construirSaturno; exit;;
b.Unix) construirUtilUnix; exit;;
b.Andromeda) construirBaseAndromeda; exit;;
hexagonix) hexagonix; exit;;
andromeda) construtorAndromeda; exit;;
limpar) limpar; exit;;
configure) executarConfigure; exit;;
configurar) executarConfigure; exit;;

# Função padrão

# *) construtorAndromeda; exit;;
*) parametrosNecessarios; exit;;

esac 
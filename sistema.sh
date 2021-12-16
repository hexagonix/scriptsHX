#!/bin/sh
#
# Esse script deve ficar na raiz do projeto
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

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="andromeda.img"

if [ "$IDIOMA" = "pt" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="andromeda.img"

elif [ "$IDIOMA" = "en" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=EN"
export imagemFinal="en.andromeda.img"

fi

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
echo "Construindo o Sistema Operacional Andromeda® (Hexagon® + utilitários)..."
echo

mkdir -p Andromeda

echo "Componentes de inicialização do Hexagon®... {"
echo

echo "Componentes de inicialização do Hexagon®... {" >> $REG
echo >> $REG

echo "Carregador de inicialização do Hexagon® - Saturno® (1º estágio)..."
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

echo "Hexagon Boot - HBoot (2º estágio)..."
echo

echo "Hexagon Boot - HBoot (2º estágio)..." >> ../log.log
echo >> ../log.log

cd "Hexagon Boot"

fasm hboot.asm ../hboot -d $BANDEIRASHBOOT >> ../../log.log || erroConstrucao

cd Mods

if [ -e *.asm ] ; then

for i in *.asm
do

	echo -n Gerando módulo compatível com HBoot® $(basename $i .asm).mod...
	
	fasm $i ../../`basename $i .asm`.mod -d $BANDEIRAS >> ../../../log.log 
	
	echo " [Ok]"
	
done

fi

cd ..

cd ..

cp *.img ../Andromeda
cp hboot ../Andromeda

if [ -e *.mod ] ; then

cp *.mod ../Andromeda/ 
rm -r *.mod 

fi	

rm -r *.img
rm -r hboot

echo
echo "} Componentes de inicialização gerados com sucesso."

echo >> ../log.log
echo "} Componentes de inicialização do Hexagon® construídos com sucesso." >> ../log.log
echo >> ../log.log
echo "----------------------------------------------------------------------" >> ../log.log
echo >> ../log.log

cd ..

cd Hexagon

echo
echo -n "Kernel Hexagon®..."

echo "Kernel Hexagon®..." >> ../log.log
echo >> ../log.log

fasm Hexagon.asm Hexagon.sis -d $BANDEIRASHEXAGON >> ../log.log || erroConstrucao

cp Hexagon.sis ../Andromeda

rm -r Hexagon.sis

echo " [Ok]"

echo >> ../log.log
echo "Kernel Hexagon® construído com sucesso." >> ../log.log
echo >> ../log.log
echo "----------------------------------------------------------------------" >> ../log.log
echo >> ../log.log

cd ..

# Gerar os aplicativos base do Andromeda® e base Unix

cd Apps/Unix

./Unix.sh

cd ..

cd Andromeda
	
./Apps.sh

cd ..

cp *.app ../Andromeda
rm *.app

cd ..

cd Dist 

cd etc/

cp *.* ../../Andromeda

cd ..

cd Man

cp *.* ../../Andromeda

cd ..
cd ..

cd Fontes/

if [ -e Atomic.asm ] ; then

echo -n "Existem fontes a serem construidas e copiadas..."
echo

./fontes.sh

cp *.fnt ../Andromeda
rm *.fnt

echo
echo "Fontes copiadas [Ok]"
echo

else 

echo 
echo "Não existem fontes a serem construidas e copiadas... [Ok]"
echo

fi

echo "Copiando principais bibliotecas de desenvolvimento..."
echo 

# Vamos copiar também o arquivo de cabeçalho para poder desenvolver sobre o Andromeda(R)

cd ..

cd LibAPP/

cp andrmda.s ../Andromeda 

cd Estelar

cp estelar.s ../../Andromeda

cd ..
cd ..

echo "Bibliotecas copiadas [Ok]"
echo

if [ -e Externos/Externos.sh ] ; then

echo 
echo "Construindo aplicativos de terceiros..."
echo 

cd Externos 

./Externos.sh Andromeda

cd ..

echo 
echo "Aplicativos de terceitos construídos [Ok]"

else 

echo "Não existem aplicativos de terceiros marcados para construção."
echo 

fi 

cd Dist 

echo
echo "Visualize o arquivo de log 'log.log', para mais informações da montagem."
echo

}

hexagonix()
{

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=UNIX -d VERBOSE=SIM -d IDIOMA=PT"

if [ "$IDIOMA" = "pt" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=UNIX -d VERBOSE=SIM -d IDIOMA=PT"

elif [ "$IDIOMA" = "en" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=UNIX -d VERBOSE=SIM -d IDIOMA=EN"

fi

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
echo "Construindo o Sistema Operacional Hexagonix® (Hexagon® + utilitários)..."
echo

mkdir -p Hexagonix

echo "Componentes de inicialização do Hexagon®... {"
echo

echo "Componentes de inicialização do Hexagon®... {" >> $REG
echo >> $REG

echo "Carregador de inicialização do Hexagon® - Saturno® (1º estágio)..."
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

echo "Hexagon Boot - HBoot (2º estágio)..."
echo

echo "Hexagon Boot - HBoot (2º estágio)..." >> ../log.log
echo >> ../log.log

cd "Hexagon Boot"

fasm hboot.asm ../hboot -d $BANDEIRASHBOOT >> ../../log.log || erroConstrucao

cd Mods

if [ -e *.asm ] ; then

for i in *.asm
do

	echo -n Gerando módulo compatível com HBoot® $(basename $i .asm).mod...
	
	fasm $i ../../`basename $i .asm`.mod -d $BANDEIRAS >> ../../../log.log 
	
	echo " [Ok]"
	
done

fi

cd ..

cd ..

cp *.img ../Hexagonix
cp hboot ../Hexagonix

if [ -e *.mod ] ; then

cp *.mod ../Hexagonix/ 
rm -r *.mod 

fi	

rm -r *.img
rm -r hboot

echo
echo "} Componentes de inicialização gerados com sucesso."

echo >> ../log.log
echo "} Componentes de inicialização do Hexagon® construídos com sucesso." >> ../log.log
echo >> ../log.log
echo "----------------------------------------------------------------------" >> ../log.log
echo >> ../log.log

cd ..

cd Hexagon

echo
echo -n "Kernel Hexagon®..."

echo "Kernel Hexagon®..." >> ../log.log
echo >> ../log.log

fasm Hexagon.asm Hexagon.sis -d $BANDEIRASHEXAGON >> ../log.log || erroConstrucao

cp Hexagon.sis ../Hexagonix

rm -r Hexagon.sis

echo " [Ok]"

echo >> ../log.log
echo "Kernel Hexagon® construído com sucesso." >> ../log.log
echo >> ../log.log
echo "----------------------------------------------------------------------" >> ../log.log
echo >> ../log.log

cd ..

# Gerar os aplicativos base Unix

cd Apps/Unix

./Unix.sh hexagonix

cd ..

cp *.app ../Hexagonix
rm *.app

cd ..

cd Dist 

cd etc/

cp *.* ../../Hexagonix

cd ..

cd Man

cp *.* ../../Hexagonix

cd ..
cd ..

cd Fontes/

if [ -e Atomic.asm ] ; then

echo -n "Existem fontes a serem construidas e copiadas..."
echo

./fontes.sh

cp *.fnt ../Hexagonix
rm *.fnt

echo
echo "Fontes copiadas [Ok]"
echo

else 

echo 
echo "Não existem fontes a serem construidas e copiadas... [Ok]"
echo

fi

cd ..

echo "Copiando principais bibliotecas de desenvolvimento..."
echo 

# Vamos copiar também o arquivo de cabeçalho para poder desenvolver sobre o Andromeda(R)

cd LibAPP/

cp andrmda.s ../Hexagonix/hexagon.s 

cd ..

echo "Bibliotecas copiadas [Ok]"
echo

if [ -e Externos/Externos.sh ] ; then

echo 
echo "Construindo aplicativos de terceiros..."
echo 

cd Externos 

./Externos.sh Hexagonix

cd ..

echo
echo "Aplicativos de terceitos construídos [Ok]"

else 

echo "Não existem aplicativos de terceiros marcados para construção."
echo 

fi 

cd Dist 

echo 
echo "Visualize o arquivo de log 'log.log', para mais informações da montagem."
echo

}

erroConstrucao(){
	
echo "Um erro ocorreu durante a construção de algum componente do sistema."
echo 
echo "Verifique o status dos componentes e utilize as saídas de erro acima para verificar o problema."
echo 
echo "Visualize o arquivo de log 'log.log', para mais informações sobre o(s) erro(s)."
echo 

umount -a >> /dev/null

exit	

}

limpar(){
	
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
echo "Limpando componentes gerados e imagens do Sistema..."
echo
echo
	
rm -r Sistema >> /dev/null
rm -r Andromeda >> /dev/null
rm -r Hexagonix >> /dev/null
rm -r andromeda.img >> /dev/null
rm -r hexagonix.img >> /dev/null
rm -r log.log >> /dev/null
rm -r COM1.txt >> /dev/null
rm -r *.sis >> /dev/null
rm -r *.bin >> /dev/null
rm -r *.app >> /dev/null

echo
echo "Pronto!"
echo
		
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

sudo qemu-system-$sistema -serial file:"COM1.txt"  -hda $imagem -cpu $processador -m $memoria -soundhw $drvsom -no-kvm >> /dev/null || erroMV
	
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
echo "Construindo Hexagon®..."
echo

cd Hexagon

fasm Hexagon.asm ../Hexagon.sis -d $BANDEIRASHEXAGON || erroConstrucao

echo -e

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

# Variáveis e constantes utilizados na máquina virtual (QEMU)
	
export drvsom="pcspk"
export sistema="i386"
export imagem="andromeda.img"
export processador="core2duo"
export memoria=128
export REG="log.log"

# Agora vamos exportar flags (bandeiras) para as etapas de montagem e/ou compilação

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export BANDEIRASHEXAGON="VERBOSE=SIM"
export BANDEIRASHBOOT="TEMATOM=ANDROMEDA"
export IDIOMA=$2

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


# Realizar a ação determinada pelo parâmetro fornecido

case $1 in

limpar) limpar; exit;;
mv) maquinaVirtual; exit;;
kernel) kernel; exit;;
hexagonix) hexagonix; exit;;
andromeda) construtor; exit;;
*) construtor; exit;;

esac 
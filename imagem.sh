#!/bin/bash
#
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

andromeda()
{
		
clear

echo ";;****************************************************************************"
echo ";;                                                                            "
echo ";;                                                                            "
echo ";; ┌┐ ┌┐                              Sistema Operacional Hexagonix®          "
echo ";; ││ ││                                                                      "
echo ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ Copyright © 2016-2022 Felipe Miguel Nery Lunkes"
echo ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       Todos os direitos reservados             "
echo ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo ";;              ┌─┘│                                                          "
echo ";;              └──┘                                                          "
echo ";;                                                                            "
echo ";;****************************************************************************"
echo
echo

echo
echo "Construindo o Sistema..."
echo

# Agora os arquivos do Sistema serão gerados...

./sistema.sh andromeda $Par

# Agora a imagem do Sistema será preparada...

echo "Construindo imagem do Sistema..."
echo

echo "Construindo imagem temporária para manipulação de arquivos......" >> $LOG

dd status=none bs=512 count=$TAMANHOTEMP if=/dev/zero of=temp.img >> $LOG || erroMontagem

if [ ! -e andromeda.img ] ; then

echo >> $LOG
echo "Construindo imagem que receberá os arquivos do Sistema..." >> $LOG
echo >> $LOG

dd status=none bs=$TAMANHOIMAGEM count=1 if=/dev/zero of=$IMG >> $LOG || erroMontagem
	
fi	

echo "> Copiando Carregador de Inicialização para a imagem..." >> $LOG

dd status=none conv=notrunc if=Andromeda/saturno.img of=temp.img >> $LOG || erroMontagem

echo "> Montando a imagem..." >> $LOG
 
mkdir -p Sistema && mount -o loop -t vfat temp.img Sistema/ || erroMontagem

echo "> Copiando arquivos do Sistema para a imagem..." >> $LOG
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

mv  andromeda.img Imagens/$imagemFinal

echo ";;****************************************************************************"
echo ";;                                                                            "
echo ";;                                                                            "
echo ";; ┌┐ ┌┐                              Sistema Operacional Hexagonix®          "
echo ";; ││ ││                                                                      "
echo ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ Copyright © 2016-2022 Felipe Miguel Nery Lunkes"
echo ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       Todos os direitos reservados             "
echo ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo ";;              ┌─┘│                                                          "
echo ";;              └──┘                                                          "
echo ";;                                                                            "
echo ";;****************************************************************************"
echo
echo
echo "Imagem '$IMG' gerada com sucesso. Ela pode ser encontrada em Imagens/$imagemFinal."
echo
echo
echo ";;****************************************************************************"
echo

echo "> Imagem '$IMG' gerada com sucesso." >> $LOG
echo >> $LOG
echo "Utilize './sistema mv' para testar a execução do Sistema na imagem gerada ou copie" >> $LOG
echo "a imagem para o diretório 'Inst' da raiz do instalador para gerar uma imagem de instalação" >> $LOG
echo "baseada em Linux para transferência para um disco." >> $LOG
echo >> $LOG
echo "----------------------------------------------------------------------" >> $LOG
echo >> $LOG

exit

}

hexagonix()
{

clear

echo ";;****************************************************************************"
echo ";;                                                                            "
echo ";;                                                                            "
echo ";; ┌┐ ┌┐                              Sistema Operacional Hexagonix®          "
echo ";; ││ ││                                                                      "
echo ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ Copyright © 2016-2022 Felipe Miguel Nery Lunkes"
echo ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       Todos os direitos reservados             "
echo ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo ";;              ┌─┘│                                                          "
echo ";;              └──┘                                                          "
echo ";;                                                                            "
echo ";;****************************************************************************"
echo
echo
echo
echo "Construindo o Sistema..."
echo

# Agora os arquivos do Sistema serão gerados...

./sistema.sh hexagonix $PT2

# Agora a imagem do Sistema será preparada...

echo "Construindo imagem do Sistema..."
echo

echo "Construindo imagem temporária para manipulação de arquivos......" >> $LOG

dd status=none bs=512 count=$TAMANHOTEMP if=/dev/zero of=temp.img >> $LOG || erroMontagem

if [ ! -e hexagonix.img ] ; then

echo >> $LOG
echo "Construindo imagem que receberá os arquivos do Sistema..." >> $LOG
echo >> $LOG

dd status=none bs=$TAMANHOIMAGEM count=1 if=/dev/zero of=$IMG >> $LOG || erroMontagem
	
fi	

echo "> Copiando Carregador de Inicialização para a imagem..." >> $LOG

dd status=none conv=notrunc if=Hexagonix/saturno.img of=temp.img >> $LOG || erroMontagem

echo "> Montando a imagem..." >> $LOG
 
mkdir -p Sistema && mount -o loop -t vfat temp.img Sistema/ || erroMontagem

echo "> Copiando arquivos do Sistema para a imagem..." >> $LOG
echo >> $LOG

cp Hexagonix/*.man Sistema/ >> $LOG || erroMontagem

if [ -e Hexagonix/*.asm ] ; then

cp Hexagonix/*.asm Sistema/ >> $LOG

fi	

cp Hexagonix/*.s Sistema/ >> $LOG
cp Hexagonix/*.cow Sistema/ >> $LOG || erroMontagem
cp Hexagonix/*.app Sistema/ >> $LOG || erroMontagem
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

mv hexagonix.img Imagens/$imagemFinal

echo ";;****************************************************************************"
echo ";;                                                                            "
echo ";;                                                                            "
echo ";; ┌┐ ┌┐                              Sistema Operacional Hexagonix®          "
echo ";; ││ ││                                                                      "
echo ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ Copyright © 2016-2022 Felipe Miguel Nery Lunkes"
echo ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       Todos os direitos reservados             "
echo ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo ";;              ┌─┘│                                                          "
echo ";;              └──┘                                                          "
echo ";;                                                                            "
echo ";;****************************************************************************"
echo
echo
echo "Imagem '$IMG' gerada com sucesso. Ela pode ser encontrada em Imagens/$imagemFinal."
echo
echo
echo ";;****************************************************************************"
echo

echo "> Imagem '$IMG' gerada com sucesso." >> $LOG
echo >> $LOG
echo "Utilize './sistema mv' para testar a execução do Sistema na imagem gerada ou copie" >> $LOG
echo "a imagem para o diretório 'Inst' da raiz do instalador para gerar uma imagem de instalação" >> $LOG
echo "baseada em Linux para transferência para um disco." >> $LOG
echo >> $LOG
echo "----------------------------------------------------------------------" >> $LOG
echo >> $LOG

exit

}

erroMontagem()
{

if test $VERBOSE -e 0; then

clear

elif test $VERBOSE -e 1; then

echo 

fi


echo ";;****************************************************************************"
echo ";;                                                                            "
echo ";;                                                                            "
echo ";; ┌┐ ┌┐                              Sistema Operacional Hexagonix®          "
echo ";; ││ ││                                                                      "
echo ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ Copyright © 2016-2022 Felipe Miguel Nery Lunkes"
echo ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       Todos os direitos reservados             "
echo ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo ";;              ┌─┘│                                                          "
echo ";;              └──┘                                                          "
echo ";;                                                                            "
echo ";;****************************************************************************"
echo
echo
echo "Algo de errado ocorreu durante a montagem da imagem :("
echo
echo "Utilize o script de geração do Sistema para verificar a origem do problema."
echo

umount Sistema/ >> /dev/null
umount Andromeda/ >> /dev/null

exit
	
}

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

# Agora vamos para a função que vai gerar a imagem para o Hexagonix®

hexagonix

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

# Agora vamos para a função que vai gerar a imagem para o Andromeda®

andromeda

}

definirAndromedaOficial()
{

# Aqui vamos definir uma imagem de tamanho oficial, que demora mais a ser gerada. Essa imagem é
# apropriada para o pacote de instalação do Andromeda®

export LOG="log.log"
export IMG="andromeda.img"
export TAMANHOIMAGEM=47185920
export TAMANHOTEMP=92160	

# Agora vamos para a função que vai gerar a imagem para o Andromeda®

andromeda

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

# Ponto de entrada do Script

if test "`whoami`" != "root" ; then

clear

echo ";;****************************************************************************"
echo ";;                                                                            "
echo ";;                                                                            "
echo ";; ┌┐ ┌┐                              Sistema Operacional Hexagonix®          "
echo ";; ││ ││                                                                      "
echo ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ Copyright © 2016-2022 Felipe Miguel Nery Lunkes"
echo ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       Todos os direitos reservados             "
echo ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo ";;              ┌─┘│                                                          "
echo ";;              └──┘                                                          "
echo ";;                                                                            "
echo ";;****************************************************************************"
echo
echo
echo "Para iniciar o processo solicitado, voce deve ser um superusuario ;D"
echo
echo "Voce deve logar como superusuario\nUtilize sudo $0.\n" && exit
	
fi

export PT2=$2
export PT3=$3
export PT4=$4
export PT5=$5

case $1 in

hexagonix) definirHexagonix; exit;;
andromeda) definirAndromedaTeste; exit;;
oficial) definirAndromedaOficial; exit;;
verbose) definirVerbose; exit;;
*) definirAndromedaTeste; exit;;

esac

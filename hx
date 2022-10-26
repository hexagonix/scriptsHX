#!/bin/bash
# Esse script deve ficar na raiz do projeto
# 
# Esse script foi desenvolvido para rodar sobre o Linux e versão do QEMU para Linux.
# Pode funciona rodando sobre o WSL 2.
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

# Sessão de ajuda e informações sobre o hx

exibirAjuda() {

clear

export MSG="Ajuda do hx"

banner 

echo -e "Parâmetros \e[1;94mprincipais\e[0m disponíveis:"
echo 
echo -e "\e[1;32m-v\e[0m - Iniciar uma máquina virtual. Os parâmetros disponíveis são:"
echo -e "\e[1;32m  hx\e[0m  - Iniciar máquina virtual do Hexagonix"
echo -e "\e[1;32m  hx.som\e[0m - Iniciar máquina virtual do Hexagonix em modo com som"
echo -e "\e[1;32m  hx.serial\e[0m - Iniciar máquina virtual do Hexagonix sem saída serial"
echo -e "\e[1;32m  bsd-hx\e[0m - Iniciar máquina virtual compatível com host BSD"
echo 
echo -e "\e[1;32m-i\e[0m - Construir imagem de disco. Os parâmetos disponíveis são:"
echo -e "\e[1;32m  hx\e[0m - Construir imagem de disco com o Hexagonix"
echo -e "\e[1;32m  hx.teste\e[0m - Construir imagem de disco teste com o Hexagonix"
echo
echo -e "\e[1;32m-u\e[0m - Sincronizar as imagens do Hexagonix com o repositório oficial"
echo
echo -e "\e[1;32mlimpar\e[0m - Limpa os arquivos de configuração e binários da árvore do sistema"

echo 

}

exibirCopyright() {

clear 

export MSG="Copyright"

banner

echo -e "\e[1;94mHX: Ferramenta de construção e testes do Hexagonix® versão $VERSAOHX\e[0m"
echo
echo -e "Desenvolvido por \e[1;32mFelipe Miguel Nery Lunkes\e[0m"
echo 
echo -e "\e[0mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e "\e[0mTodos os direitos reservados.\e[0m"
echo

}

parametrosNecessarios(){

clear

export MSG="Ajuda do hx"

banner 

echo -e "Você precisa fornecer pelo menos um parâmetro para o HX."
echo 
echo -e "\e[1;94mDica: utilize \e[1;32m./hx ajuda \e[1;94mou \e[1;32m$NOMEHX ajuda\e[1;94m para obter os parâmetros"
echo -e "\e[1;94mdisponíveis.\e[0m"
echo

}

# Sessão de configuração para montagem do sistema

prepImagemHexagonix(){

iniciarLog

definirHexagonixOficial
imagemHexagonix

}

prepImagemHexagonixTeste(){

iniciarLog

definirHexagonixTeste
imagemHexagonix

}

# Porção de código responsável por gerar a imagem do sistema
#
# Incluído a partir do script imagem.sh

definirHexagonixTeste()
{

# Aqui vamos gerar uma imagem pequena, de 2 Mb, menor e apenas para testes. Essa imagem
# não deve ser utilizada para o pacote de instalação.

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="hexagonix.img"
export Par="pt"

if [ "$PT2" = "pt" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="hexagonix.img"
export Par="pt"

elif [ "$PT2" = "en" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=EN"
export imagemFinal="en.andromeda.img"
export Par="en"

fi

export LOG="log.log"
export IMG="hexagonix.img"
export TAMANHOIMAGEM=2097012
export TAMANHOTEMP=2048	

}

definirHexagonixOficial()
{

# Aqui vamos definir uma imagem de tamanho oficial, que demora mais a ser gerada. Essa imagem é
# apropriada para o pacote de instalação do Andromeda®

export LOG="log.log"
export IMG="hexagonix.img"
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

# Sessão de construtores individuais dos componentes do sistema

# Vamos separar aqui as etapas comuns de construção do sistema para reutilizar
# código e facilitar a busca de erros

construirHexagon(){

cd Hexagon

echo
echo -en "\e[1;94mConstruindo o Kernel Hexagon®...\e[0m"

echo "Kernel Hexagon®..." >> ../log.log
echo >> ../log.log

fasm kern/Hexagon.asm Hexagon -d $BANDEIRASHEXAGON >> ../log.log || erroConstrucao

cp Hexagon ../$DESTINODISTRO/bin

rm -r Hexagon

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

}

construirBaseAndromeda(){

cd $DESTINODISTRO
	
./Apps.sh

cd ..

cd ..

}

kernel()
{

kernel

}

erroMontagem()
{

if test $VERBOSE -e 0; then

clear

elif test $VERBOSE -e 1; then

echo 

fi

export MSG="Erro na construção do sistema"

banner 
echo
echo -e "\e[1;31mAlgo de errado ocorreu durante a montagem da imagem :(\e[0m"
echo
echo "Utilize o script de geração do Sistema para verificar a origem do problema."
echo

umount Sistema/ >> /dev/null
umount $DESTINODISTRO/ >> /dev/null

exit
	
}

# Sessão de construção coletiva dos componentes do sistema

gerenciarConstrucao()
{

case $PT2 in

hx) prepImagemHexagonix; exit;;
hx.teste) prepImagemHexagonixTeste; exit;;
distros) prepDistros; exit;;

*) parametrosNecessarios; exit;;

esac

}

gerenciarConstrucaoComponentes()
{

case $PT2 in

hexagon) construirHexagon; exit;;
hBoot) construirHBoot; exit;;
saturno) construirSaturno; exit;;
unixland) construirUtilUnix; exit;;
andromedaland) construirBaseAndromeda; exit;;
hexagonix) hexagonix; exit;;
andromeda) construtorAndromeda; exit;;

*) parametrosNecessarios; exit;;

esac

}

construtorHexagonix()
{

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="hexagonix.img"

if [ "$IDIOMA" = "pt" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export imagemFinal="hexagonix.img"

elif [ "$IDIOMA" = "en" ]; then

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=EN"
export imagemFinal="en.andromeda.img"

fi

export DESTINODISTRO="Andromeda"
export MSG="Construir o hx"

banner 

echo
echo "Construindo o Sistema Operacional Hexagonix® (Hexagonix base + utilitários)..."
echo

mkdir -p $DESTINODISTRO
mkdir -p $DESTINODISTRO/bin

construirSaturno
construirHBoot
construirHexagon
construirUtilUnix
construirBaseAndromeda

cd Dist 

cd etc/

cp *.unx ../../$DESTINODISTRO
cp base.ocl ../../$DESTINODISTRO/hexgnix.ocl

cd ..

cd man

cp *.man ../../$DESTINODISTRO

cd ..
cd ..

cd Fontes/

if [ -e Atomic.asm ] ; then

echo -e "Existem fontes a serem construidas e copiadas... [\e[32mOk\e[0m]"

./fontes.sh

cp *.fnt ../$DESTINODISTRO
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

# Vamos copiar também o arquivo de cabeçalho para poder desenvolver sobre o Hexagonix(R)

cd ..

cd lib/fasm

cp hexagon.s ../../$DESTINODISTRO 

cd Estelar

cp estelar.s ../../../$DESTINODISTRO

cd ..
cd ..

cd exemplo

cp * ../../$DESTINODISTRO/

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

erroConstrucao(){
	
echo "Um erro ocorreu durante a construção de algum componente do sistema."
echo 
echo "Verifique o status dos componentes e utilize as saídas de erro acima para verificar o problema."
echo 
echo "Visualize o arquivo de log 'log.log', para mais informações sobre o(s) erro(s)."
echo 

umount Sistema/ >> /dev/null
umount $DESTINODISTRO/ >> /dev/null

exit	

}

# Sessão de criação de imagem do sistema

imagemHexagonix()
{

if test "`whoami`" != "root" ; then

sureq

exit

fi

clear 

export MSG="Construir o Hexagonix"

banner

echo "Construindo o Hexagonix..."
echo

# Agora os arquivos do Sistema serão gerados...

construtorHexagonix $Par

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

dd status=none conv=notrunc if=$DESTINODISTRO/saturno.img of=temp.img >> $LOG || erroMontagem

echo "> Montando a imagem..." >> $LOG
 
mkdir -p Sistema && mount -o loop -t vfat temp.img Sistema/ || erroMontagem

echo "> Copiando arquivos do sistema para a imagem..." >> $LOG
echo >> $LOG

cp $DESTINODISTRO/*.man Sistema/ >> $LOG || erroMontagem
cp $DESTINODISTRO/*.asm Sistema/ >> $LOG
cp $DESTINODISTRO/*.s Sistema/ >> $LOG
cp $DESTINODISTRO/*.cow Sistema/ >> $LOG || erroMontagem
cp $DESTINODISTRO/bin/* Sistema/ >> $LOG || erroMontagem
cp $DESTINODISTRO/hboot Sistema/ >> $LOG || erroMontagem

# A licença deve ser copiada

cp hexagonix/LICENSE Sistema/ >> $LOG || erroMontagem

# Agora, copiar módulos do HBoot

if [ -e $DESTINODISTRO/Spartan.mod ] ; then

cp $DESTINODISTRO/*.mod Sistema/ >> $LOG

fi	

cp $DESTINODISTRO/*.unx Sistema/ >> $LOG || erroMontagem
cp $DESTINODISTRO/*.ocl Sistema/ >> $LOG || erroMontagem

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

if [ -e $DESTINODISTRO/Atomic.fnt ] ; then

echo " [Sim]" >> $LOG

cp $DESTINODISTRO/*.fnt Sistema/ || erroMontagem
	
fi	

if [ ! -e $DESTINODISTRO/Atomic.fnt ] ; then

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

dd status=none conv=notrunc if=$DESTINODISTRO/mbr.img of=$IMG >> $LOG || erroMontagem

echo "> Removendo arquivos e pastas temporárias, além de binários que não são mais necessários..." >> $LOG
echo >> $LOG

rm -rf Sistema $DESTINODISTRO temp.img >> $LOG

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

export MSG="Construir o Hexagonix"

banner 

echo
echo -e "\e[32mSucesso ao construir o sistema e a imagem de disco.\e[0m"
echo
echo -e "Veja agora algumas informações da construção \e[1matual\e[0m do sistema:"
echo -e " > Versão do Hexagonix base: \e[1;32m$VERSAO\e[0m"
echo -e " > Revisão do software: \e[1;32m$REVISAO\e[0m"
echo -e " > Nome do lançamento: \e[1;32m$CODENOME\e[0m"
echo -e " > Localização da imagem: \e[1;32m$dirImagem/$imagemFinal\e[0m"
echo

echo "> Imagem '$IMG' gerada com sucesso." >> $LOG
echo >> $LOG
echo "Utilize './hx -v hx' para testar a execução do sistema na imagem gerada ou copie" >> $LOG
echo "a imagem para o diretório 'Inst' da raiz do instalador para gerar uma imagem de instalação" >> $LOG
echo "baseada em Linux para transferência para um disco." >> $LOG
echo >> $LOG
echo "----------------------------------------------------------------------" >> $LOG
echo >> $LOG

exit

}

# Sessão de gerenciamento de máquinas virtuais do hx

gerenciarMaquinaVirtual()
{

case $PT2 in

bsd-hx) mvHexagonixSobreBSD; exit;;
hx) mvHexagonixKVM; exit;;
hx.som) mvHexagonixSnd; exit;;
hx.serial) mvHexagonixSerial; exit;;

*) parametrosNecessarios; exit;;

esac

}

mvHexagonixSnd()
{

if [ -e $imagem ] ; then

clear

export MSG="HX: iniciar máquina virtual"

banner 

echo
echo -e "\e[1mIniciando máquina virtual com as seguintes especificações:\e[0m"
echo
echo -e "> Arquitetura de destino da imagem: \e[1;32m$sistema\e[0m"
echo -e "> Imagem de disco: \e[1;32m$imagem\e[0m"
echo -e "> Saída de som: \e[1;32m$drvsom\e[0m"
echo -e "> Memória: \e[1;32m$memoria megabytes\e[0m; processador: \e[1;32m$processador\e[0m"
echo

qemu-system-$sistema -serial file:"Serial.txt" -hda $imagem -cpu $processador -m $memoria -soundhw $drvsom >> /dev/null || erroMV

else

erroMV

fi	
	
}	

mvHexagonixSobreBSD()
{

if [ -e $imagem ] ; then

clear

export MSG="HX: iniciar máquina virtual"

banner 

echo -e "\e[1mIniciando máquina virtual com as seguintes especificações:\e[0m"
echo
echo -e "\e[1;31mUsando parâmetros compatíveis com sistemas BSD (FreeBSD como modelo)\e[0m"
echo
echo -e "> Arquitetura de destino da imagem: \e[1;32m$sistemaBSD\e[0m; \e[1;31mModo BSD!\e[0m"
echo -e "> Imagem de disco: \e[1;32m$imagem\e[0m"
echo -e "> Saída de som: \e[1;32m$drvsom\e[0m"
echo -e "> Memória: \e[1;32m$memoria megabytes\e[0m; processador: \e[1;32m$processador\e[0m"
echo

qemu-system-$sistemaBSD -cpu $processador -hda $imagem -m $memoria >> /dev/null || erroMV

else

erroMV

fi	

}	

mvHexagonixKVM()
{

if [ -e $imagem ] ; then

clear

export MSG="HX: iniciar máquina virtual"

banner 

echo -e "\e[1mIniciando máquina virtual com as seguintes especificações:\e[0m"
echo
echo -e "> Arquitetura de destino da imagem: \e[1;32m$sistema\e[0m; Usando KVM!"
echo -e "> Imagem de disco: \e[1;32m$imagem\e[0m"
echo -e "> Saída de som: \e[1;32m$drvsom\e[0m"
echo -e "> Memória: \e[1;32m$memoria megabytes\e[0m; processador: \e[1;32mhost\e[0m"
echo

qemu-system-$sistema --enable-kvm -serial file:"Serial.txt" -cpu host -hda $imagem -m $memoria >> /dev/null || erroMV

else

erroMV

fi	

}	

mvHexagonixSerial()
{

if [ -e $imagem ] ; then

clear

export MSG="HX: iniciar máquina virtual"

banner 

echo -e "\e[1mIniciando máquina virtual com as seguintes especificações:\e[0m"
echo
echo -e "> Arquitetura de destino da imagem: \e[1;32m$sistema\e[0m"
echo -e "> Imagem de disco: \e[1;32m$imagem\e[0m"
echo -e "> Saída de som: \e[1;32m$drvsom\e[0m"
echo -e "> Memória: \e[1;32m$memoria megabytes\e[0m; processador: \e[1;32m$processador\e[0m"
echo

qemu-system-$sistema -serial stdio -hda $imagem -cpu $processador -m $memoria >> /dev/null || erroMV

else

erroMV

fi	
	
}	

erroMV()
{
	
clear

export MSG="HX: iniciar máquina virtual"

banner 

echo -e "Erro na solicitação: \e[1;94mimagem de disco '$imagem' não localizada ou falha\e[0m"
echo -e "\e[0mem algum componente ou parâmetro fornecido."
echo -e " > \e[1;31mVocê NÃO pode iniciar o sistema sem essa dependência\e[0m."
echo -e "Erro na solicitação: \e[1;94mproblema durante a execução da máquina virtual\e[0m."
echo -e " > \e[1;31mTente executar a máquina virtual novamente\e[0m."
echo
	
}

# Sessão de utilidades do hx

limpar(){
	
clear

export MSG="HX: limpar árvore do sistema"

banner 

echo "Executando limpeza na árvore do sistema..."
echo -n " > Limpando componentes gerados e imagens do sistema..."
	
rm -rf Sistema $DESTINODISTRO Hexagonix andromeda.img hexagonix.img
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

infoBuild(){

clear

export MSG="Informações do sistema"

banner 
echo -e "Veja agora algumas informações e definições da construção \e[1matual\e[0m do sistema:"
echo -e " > Versão do Hexagonix base: \e[1;32m$VERSAO\e[0m"
echo -e " > Revisão do software: \e[1;32m$REVISAO\e[0m"
echo -e " > Nome do lançamento: \e[1;32m$CODENOME\e[0m"
echo

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

export MSG="Estatísticas"

banner 

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

	echo
	echo -en "\e[1;94mEstatísticas globais do sistema:\e[0m"
	echo 
	echo 

	cloc $(pwd)

	terminar 

tudopronto 

else

echo
echo -e "[\e[1;31mUtilitário cloc não localizado.\e[0m]"
echo -e "\e[1;94mO HX não pode gerar relatório de estatísticas sem essa dependência.\e[0m"

fi	

echo

}


iniciarLog()
{

if [ -e $REG ] ; then

rm -r $REG
	
fi	

# Montar o cabeçalho do arquivo de log...

echo "Relatório de montagem e estatísticas do Sistema Operacional Hexagonix®" >> $REG
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

instalarDependencias(){

if test "`whoami`" != "root" ; then

sureq

exit

fi

export MSG="Instalar dependências"

banner 

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

banner()
{ 

echo -e ";;****************************************************************************"
echo -e ";;                                                                            "
echo -e ";;                                                                            "
echo -e ";; ┌┐ ┌┐                              \e[1;94mSistema Operacional Hexagonix®\e[0m          "
echo -e ";; ││ ││                                                                      "
echo -e ";; │└─┘├──┬┐┌┬──┬──┬──┬─┐┌┬┐┌┐ \e[1;94mCopyright © 2016-2022 Felipe Miguel Nery Lunkes\e[0m"
echo -e ";; │┌─┐││─┼┼┼┤┌┐│┌┐│┌┐│┌┐┼┼┼┼┘       \e[1;94mTodos os direitos reservados\e[0m             "
echo -e ";; ││ │││─┼┼┼┤┌┐│└┘│└┘││││├┼┼┐                                                "
echo -e ";; └┘ └┴──┴┘└┴┘└┴─┐├──┴┘└┴┴┘└┘                                                "
echo -e ";;              ┌─┘│                       \e[1;32m$MSG\e[0m "
echo -e ";;              └──┘                                                          "
echo -e ";;                                                                            "
echo -e ";;****************************************************************************"
echo

}

atualizarImagens()
{

export MSG="Atualizar imagens"

banner 

echo "Você está prestes a atualizar as imagens de disco do Hexagonix, sincronizando-as"
echo "com as disponíveis no repositório de imagens, no ramo principal (estável)."
echo -e "\e[1;31mAtenção! Esse processo destruirá qualquer modificação dentro das imagens locais!\e[0m"
echo
echo 
echo -n "Você deseja continuar [y/N] (pressione ENTER após a seleção): "

read OPCAO 

case $OPCAO in

y) atualizarAutorizado; exit;;
Y) atualizarAutorizado; exit;;
n) finalizar; exit;;
N) finalizar; exit;;
*) finalizar; exit;;

esac

}

atualizarAutorizado()
{

cd hexagonix 

rm -rf hexagonix.img hexagonix.vdi 

wget https://github.com/hexagonix/hexagonix/blob/main/hexagonix.img
wget https://github.com/hexagonix/hexagonix/blob/main/hexagonix.vdi

terminar
tudopronto

}

finalizar()
{

exit 

}

sureq()
{

clear

export MSG="HX: você precisa ser root"

banner 

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

# Dados de versão do Hexagonix

export REVISAO=$(cat Dist/etc/revisao.def)
export CODENOME=$(cat Dist/etc/codenome.def)
export VERSAO=$(cat Dist/etc/versao.def)

# Constantes para execução da máquina virtual (QEMU) 

export drvsom="pcspk"
export sistema="i386"
export sistemaBSD="x86_64"
export processador="pentium3"
export memoria=32

# Constantes para as etapas de construção do sistema e criação de imagens

export REG="log.log"
export imagem="hexagonix/hexagonix.img"
export dirImagem="hexagonix"

# Agora vamos exportar flags (bandeiras) para as etapas de montagem e/ou compilação

export BANDEIRAS="UNIX=SIM -d TIPOLOGIN=Andromeda -d VERBOSE=SIM -d IDIOMA=PT"
export BANDEIRASHEXAGON="VERBOSE=SIM"
export BANDEIRASHBOOT="TEMATOM=ANDROMEDA"

# Constantes com informações de parâmetros

export NOMEHX=$0
export PT2=$2
export PT3=$3
export PT4=$4
export PT5=$5
export IDIOMA=$2
export IDIOMANG=$3

# Versão do hx

export VERSAOHX="11.1"

# Agora, vamos definir onde estão os cabeçalhos e bibliotecas

export INCLUDE="$(pwd)/lib/fasm"

# Realizar a ação determinada pelo parâmetro fornecido

case $1 in

limpar) limpar; exit;;

# Novo mecanismo de gerenciamento de parâmetros

-v) gerenciarMaquinaVirtual; exit;;
-i) gerenciarConstrucao; exit;;
-h) exibirAjuda; exit;;
-b) gerenciarConstrucaoComponentes; exit;;
-u) atualizarImagens; exit;;
--ver) exibirCopyright; exit;;
--depend) instalarDependencias; exit;; 
--info) infoBuild; exit;;
--configure) executarConfigure; exit;;
--stat) exibirEstatisticas; exit;;

# Função padrão

*) parametrosNecessarios; exit;;

esac 
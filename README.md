# Scripts para geração do Hexagonix/Andromeda

Este repositório contém os shell scripts necessários para construir o sistema e as imagens de disco do Hexagonix e Andromeda, além de permitir testar os mesmos em uma máquia virtual, fornecendo todos os parâmetros necessários.

## Aviso de direitos autorais

* Sistema Operacional Hexagonix e Sistema Operacional Andromeda. Copyright © 2016-2022 Felipe Miguel Nery Lunkes. Todos os direitos reservados.
* Kernel Hexagon. Copyright © 2016-2022 Felipe Miguel Nery Lunkes. Todos os direitos reservados.
* Gerenciador de Boot Saturno. Copyright © 2016-2022 Felipe Miguel Nery Lunkes. Todos os direitos reservados.
* Hexagon Boot (HBoot). Copyright © 2020-2022 Felipe Miguel Nery Lunkes. Todos os direitos reservados.

# Informação de localização na árvore de construção do Hexagonix/Andromeda:

Este repositório não é necessário para a construção do Hexagonix/Andromeda. Ele serve apenas para armazenar os scripts de construção que por sua vez serão utilizados no processo. Para isso, verifique abaixo a localização de cada script, que deve ser copiado para as localizações adequadas ao iniciar uma nova árvore de construção local:

* Apps.sh[^1]: deve estar em Apps/Andromeda. Cópia backup, uma já disponível no repositório Andromeda-Apps
* Externos.sh[^2]: deve estar no diretório Externos, na raiz da árvore. Todos os repositórios com códigos de terceiros devem ser clonados no interior do diretório Externos
* imagem.sh[^3]: Deve estar no diretório raiz da árvore de construção
* sistema.sh[^4]: Deve estar no diretório raiz da árvore de construção
* Unix.sh[^5]: deve estar em Apps/Unix. Cópia backup, uma já disponível no repositório Unix-Apps
* WSL.sh[^6]: Deve estar no diretório raiz da árvore de construção

[^1]: Script responsável por construir os aplicativos do ambiente Andromeda.
[^2]: Script responsável por construir e/ou manipular os códigos de terceiros, como aplicativos e bibliotecas, que devem estar na pasta Externos, na raiz da árvore de construção do sistema.
[^3]: Script responsável por solicitar a construção do sistema por sistema.sh e gerar imagens de disco do Hexagonix e Andromeda.
[^4]: Script responsável por concentrar a operação de construção do sistema, solicitando Apps.sh, Unix.sh e Externos.sh, criando um diretório para receber as imagens e analisando possíveis erros. Também pode receber parâmetros para especificar qual sistema gerar. Esses parametros podem ser "hexagonix" e "verbose", ou ainda "verbose hexagonix" ou "verbose andromeda". Para gerar o Andromeda, nenhum parâmetro precisa ser fornecido, "andromeda" é o padrão. No Linux, ele assume o papel de gerenciar máquinas virtuais, também. Para desenvolvimento no Windows, com WSL2 e Ubuntu instalados, o script WSL.sh deve ser utilizado, uma vez que não é possível executar algumas operações de sistema.sh fora do Linux puro. Não é compatível com sistemas Windows, mesmo com WSL2.
[^5]: Script responsável por construir os aplicativos do ambiente Hexagonix.
[^6]: Script responsável por gerenciar máquinas virtuais, remover arquivos temporários e realizar outras funções em ambiente WSL2. Não é compatível com sistemas Linux.

Versão deste arquivo: 1.0
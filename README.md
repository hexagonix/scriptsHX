<p align="center">
<img src="https://github.com/hexagonix/Doc/blob/main/Img/banner.png">
</p>

<div align="center">

![](https://img.shields.io/github/license/hexagonix/scriptsHX.svg)
![](https://img.shields.io/github/stars/hexagonix/scriptsHX.svg)
![](https://img.shields.io/github/issues/hexagonix/scriptsHX.svg)
![](https://img.shields.io/github/issues-closed/hexagonix/scriptsHX.svg)
![](https://img.shields.io/github/issues-pr/hexagonix/scriptsHX.svg)
![](https://img.shields.io/github/issues-pr-closed/hexagonix/scriptsHX.svg)
![](https://img.shields.io/github/downloads/hexagonix/scriptsHX/total.svg)
![](https://img.shields.io/github/release/hexagonix/scriptsHX.svg)
[![](https://img.shields.io/twitter/follow/hexagonixOS.svg?style=social&label=Follow%20%40HexagonixOS)](https://twitter.com/hexagonixOS)

</div>

<!-- Vai funcionar como <hr> -->

<img src="https://github.com/hexagonix/Doc/blob/main/Img/hr.png" width="100%" height="2px" />

<details title="Português" align='left'>
<summary align='left'><strong>:brazil: Português</strong></summary>
<br>

### Ferramentas para construção do Hexagonix

<div align="justify">

Este repositório contém ferramentas para construir o Hexagonix e as imagens de disco do sistema, além de permitir testá-lo em uma máquia virtual, aplicando todos os parâmetros necessários.

</div>

<details title="HX" align='left'>
<summary align='center'>HX</summary>
<br>

<p align="center">
<img width="150px" height="150px" src="https://github.com/hexagonix/Doc/blob/main/Img/HX.png">
</p>

<div align="justify">

O `HX` é a ferramenta responsável por unificar toda a construção do Hexagonix, criação de imagens de disco e execução de testes em uma máquina virtual. O `HX` aceita uma série de parâmetros para personalizar a construção do sistema e o ambiente de testes. O `HX` deve estar no diretório raiz da árvore de construção do Hexagonix. Veja abaixo os parâmetros aceitos.

| Parâmetro | Ação executada |
|:---------:|:--------------:|
| `-h`| Exibe a ajuda com os principais parâmetros normalmente utilizados|
| `-v`| Inicia uma instância do `qemu` com a última imagem de disco gerada|
| `-i`| Constrói os componentes do sistema e cria uma imagem de disco (raw) e .vdi|
| `-b`| Constrói componentes individuais do Hexagonix (`hexagon`, `HBoot`, `saturno`, `unixland`, `andromedaland` ou `hx`, para todos)|
| `-u`| Atualiza todos os repositórios locais com o servidor, usando o ramo já definido|
| `-ui`| Atualiza apenas as imagens de disco com o servidor|
| `-br`| Exibe o ramo em uso para todos os repositórios|
| `-un`| Altera o ramo e sincroniza todos os repositórios com o ramo informado|
| `-m`| Verifica as dependências necessárias e clona todos os repositórios localmente|
| `-c`| Limpa todos os arquivos temporários criados durante uma construção do sistema|
| `--version`| Exibe informações de versão e copyright|
| `--depend`| Instala as dependências de construção (sistemas Debian, Ubuntu e derivados, apenas)|
| `--info`| Exibe informações do Hexagonix, como versão, revisão, ramo de desenvolvimento, etc|
| `--indent`| Inicializa o `indent.sh`, que formata e otimiza os códigos-fonte, manuais e arquivos de definição do Hexagonix|
| `--configure`| Executa o `configure.sh` para gerar os arquivos estáticos necessários para a construção|
| `--stats`| Exibe informações estatísticas sobre o Hexagonix (necessário cloc instalado)|
| `--flags`| Exibe as flags de build atualmente configuradas para o HBoot, o Hexagon e os utilitários userland|

Use `hx -h` para consultar a ajuda diretamente pelo terminal.

</div>

</details>

<details title="Módulos do HX" align='left'>
<summary align='center'>Módulos do HX</summary>
<br>

<div align="justify">

Para a construção do Hexagonix, o `hx` procura e executa uma série de módulos, localizados em `Scripts/modules`:

| Módulo | Função |
|:------:|:------:|
|`andromeda.hx`| Constrói todos os utilitários Hexagonix-Andromeda (utilitários gráficos)|
|`buildInfo.hx`| Obtêm e exibe informações sobre versão do Hexagonix, canal de desenvolvimento e build|
|`buildOnBSD.hx`| Constrói uma imagem de disco para a instalação do Hexagonix a partir de um sistema BSD (FreeBSD|
|`buildOnLinux.hx`| Constrói uma imagem de disco para a instalação do Hexagonix a partir de uma distribuição Linux|
|`buildOnUNIX.hx`| Constrói uma imagem de disco para a instalação do Hexagonix a partir de um sistema UNIX (OpenIndiana)|
|`common.hx`| Funções comuns utilizadas por todos os módulos|
|`contribBuilder.hx`| Executa o script de construção dos pacotes externos (como fasm)|
|`contribChecker.hx`| Verifica se existem pacotes externos construídos para instalação na imagem do sistema|
|`depend.hx`| Verifica e instala as dependências de construção, e clona os repositórios do Hexagonix|
|`diskBuilder.hx`| Instala os componentes do Hexagonix na imagem de disco do sistema gerada anteriormente|
|`fonts.hx`| Identifica e constrói fontes gráficas compatíveis com o sistema|
|`git.hx`| Atualiza os repositórios do sistema com o servidor remoto|
|`hboot.hx`| Executa a construção do componente `HBoot` (boot)|
|`hexagon.hx`| Executa a construção do componente `Hexagon` (kernel)|
|`logUtils.hx`| Funções úteis para a criação de logs de construção do sistema|
|`macros.hx`| Funções úteis para executar módulos a partir do utilitário `hx` ou de outros módulos|
|`saturno.hx`| Executa a construção do componente `Saturno` (boot)|
|`stat.hx`| Exibe informações estatísticas sobre o código-fonte do Hexagonix|
|`systemBuilder.hx`| Executa todos os módulos de construção dos componentes do sistema e os instala em um diretório temporário|
|`unix.hx`| Constrói todos os utilitários Unix|
|`vm.hx`| Permite a configuração e execução de máquinas virtuais utilizando uma imagem de disco gerada|

> Nenhum módulo deve ser executado diretamente. Apenas o `hx` e o `configure.sh` são feitos para execução direta pelo usuário.

</div>

</details>

<details title="Outras ferramentas" align='left'>
<summary align='center'>Outras ferramentas</summary>
<br>

<div align="justify">

* `configure.sh`: deve estar no diretório raiz da árvore de construção. É responsável por checar dependências e gerar os arquivos estáticos necessários à construção do Hexagonix, como a base de usuários `/shadow` (com as senhas em `Dist/etc/shadow.conf` já hasheadas) e as informações de build. Sua execução pode ser iniciada diretamente ou pelo `HX`, através de `hx --configure`.
* `indent.sh`: deve estar no diretório raiz da árvore de construção. Formata e otimiza fontes gráficas, manuais e arquivos de definição do Hexagonix. Pode ser iniciado pelo `HX`, através de `hx --indent`.
* `Contrib.sh`: deve estar no diretório raiz da árvore de construção. É responsável por construir e/ou manipular pacotes de terceiros, como o fasmX, cujos repositórios devem estar clonados no interior do diretório `Contrib`.

</div>

</details>

</details>

<details title="English" align='left'>
<summary align='left'><strong>:uk: English</strong></summary>
<br>

### Tools for building Hexagonix

<div align="justify">

This repository contains tools to build Hexagonix and the system disk images, in addition to allowing you to test it in a virtual machine, applying all the necessary parameters.

</div>

<details title="HX" align='left'>
<summary align='center'>HX</summary>
<br>

<p align="center">
<img width="150px" height="150px" src="https://github.com/hexagonix/Doc/blob/main/Img/HX.png">
</p>

<div align="justify">

`HX` is the tool responsible for unifying all the construction of Hexagonix, creating disk images and running tests in a virtual machine. `HX` accepts a number of parameters to customize the system build and testing environment. The `HX` must be in the root directory of the Hexagonix build tree. See below for the accepted parameters.

| Parameter | Action performed |
|:---------:|:-----------------:|
| `-h`| Displays help with commonly used key parameters|
| `-v`| Starts an instance of `qemu` with the last generated disk image|
| `-i`| Builds the system components and creates a disk image (raw) and .vdi|
| `-b`| Builds individual Hexagonix components (`hexagon`, `HBoot`, `saturno`, `unixland`, `andromedaland`, or `hx` for all of them)|
| `-u`| Updates all local repositories with the server, using the already defined branch|
| `-ui`| Only updates disk images with the server|
| `-br`| Displays the branch in use for all repositories|
| `-un`| Changes the branch and synchronizes all repositories with the given branch|
| `-m`| Checks the required dependencies and clones all repositories locally|
| `-c`| Clears all temporary files created during a system build|
| `--version`| Displays version and copyright information|
| `--depend`| Installs build dependencies (Debian, Ubuntu and derivative systems only)|
| `--info`| Displays Hexagonix information such as version, revision, development branch, etc|
| `--indent`| Starts `indent.sh`, which formats and optimizes Hexagonix source code, manuals and definition files|
| `--configure`| Runs `configure.sh` to generate the static files needed for the build|
| `--stats`| Displays statistical information about Hexagonix (cloc installed required)|
| `--flags`| Displays the build flags currently configured for HBoot, Hexagon and the userland utilities|

Use `hx -h` to check the help directly from the terminal.

</div>

</details>

<details title="HX modules" align='left'>
<summary align='center'>HX modules</summary>
<br>

<div align="justify">

To build Hexagonix, `hx` looks for and executes a series of modules, located in `Scripts/modules`:

| Module | Function |
|:------:|:--------:|
|`andromeda.hx`| Builds all Hexagonix-Andromeda utilities (graphics utilities)|
|`buildInfo.hx`| Gets and displays information about Hexagonix version, development channel and build|
|`buildOnBSD.hx`| Builds a disk image for installing Hexagonix from a BSD system|
|`buildOnLinux.hx`| Builds a disk image for installing Hexagonix from a Linux distribution|
|`buildOnUNIX.hx`| Builds a disk image for installing Hexagonix from a UNIX system (OpenIndiana)|
|`common.hx`| Common functions used by all modules|
|`contribBuilder.hx`| Runs the build script for external packages (such as fasm)|
|`contribChecker.hx`| Checks whether there are external packages built for installation in the system image|
|`depend.hx`| Checks and installs build dependencies, and clones the Hexagonix repositories|
|`diskBuilder.hx`| Installs Hexagonix components on the previously generated system disk image|
|`fonts.hx`| Identifies and builds graphic fonts compatible with the system|
|`git.hx`| Updates the system repositories with the remote server|
|`hboot.hx`| Executes the construction of the `HBoot` component (boot)|
|`hexagon.hx`| Executes the construction of the `Hexagon` component (kernel)|
|`logUtils.hx`| Useful functions for creating system build logs|
|`macros.hx`| Useful functions for running modules from the `hx` utility or other modules|
|`saturno.hx`| Executes the construction of the `Saturno` component (boot)|
|`stat.hx`| Displays statistical information about the Hexagonix source code|
|`systemBuilder.hx`| Runs all system component build modules and installs them in a temporary directory|
|`unix.hx`| Builds all Unix utilities|
|`vm.hx`| Allows the configuration and execution of virtual machines using a generated disk image|

> No module should be run directly. Only `hx` and `configure.sh` are meant for direct execution by the user.

</div>

</details>

<details title="Other Tools" align='left'>
<summary align='center'>Other tools</summary>
<br>

<div align="justify">

* `configure.sh`: must be in the root directory of the build tree. It is responsible for checking dependencies and generating the static files needed to build Hexagonix, such as the `/shadow` user database (with the passwords in `Dist/etc/shadow.conf` already hashed) and build information. It can be run directly or through `HX`, via `hx --configure`.
* `indent.sh`: must be in the root directory of the build tree. Formats and optimizes Hexagonix graphic fonts, manuals and definition files. Can be started by `HX`, via `hx --indent`.
* `Contrib.sh`: must be in the root directory of the build tree. It is responsible for building and/or manipulating third-party packages, such as fasmX, whose repositories must be cloned inside the `Contrib` directory.

</div>

</details>

</details>

<details title="Scripts License" align='left'>
<summary align='left'>Licença dos scripts/Scripts License</summary>
<br>

<div align="justify">

Hexagonix Operating System

BSD 3-Clause License

Copyright (c) 2015-2026, Felipe Miguel Nery Lunkes<br>
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

</div>

</details>

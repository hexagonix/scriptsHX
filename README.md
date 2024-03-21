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

### Ferramentas para construção do Hexagonix

<div align="justify">

Este repositório contém ferramentas para construir o Hexagonix e as imagens de disco do sistema, além de permitir testá-lo em uma máquia virtual, aplicando todos os parâmetros necessários.

</div>

<details title="HX" align='left'>
<br>
<summary align='center'>HX</summary>

<p align="center">
<img width="150px" height="150px" src="https://github.com/hexagonix/Doc/blob/main/Img/HX.png">
</p>

<div align="justify">

O `HX` é a ferramenta responsável por unificar toda a construção do Hexagonix, criação de imagens de disco e execução de testes em uma máquina virtual. O `HX` aceita uma série de parâmetros para personalizar a construção do sistema e o ambiente de testes. O `HX` deve estar no diretório raiz da árvore de construção do Hexagonix. Veja abaixo alguns dos parâmetros aceitos.

* `-i`: Criar uma imagem de disco contendo o Hexagonix. Esse parâmetro necessita de um segundo, especificando o tipo de imagem. O parâmetro secundário padrão para `-i` é `hx`, como em `hx -i hx`. Essa opção cria uma imagem de disco padrão do Hexagonix, construído com as definições padrão. Use `hx -h` para mais informações.
* `-v`: Inicia um ambiente virtual para executar o Hexagonix no `qemu`. Esse parâmetro necessita de um segundo, especificando o ambiente virtual a ser utilizado. O parâmetro secundário padrão para `-v`é `hx`, como em `hx -v hx`. Essa opção inicia uma máquina virtual com as definições padrão. Use `hx -h` para mais informações.
* `-c`: Limpa os arquivos objeto da árvore de fontes do sistema. Use `hx -h` para mais informações.
* `-h`: Exibe a ajuda padrão do `HX`, com todas as opções disponíveis.

</div>

</details>

<details title="Outras ferramentas" align='left'>
<br>
<summary align='center'>Outras ferramentas</summary>

<div align="justify">

* Contrib.sh: deve estar no diretório `Contrib`, na raiz da árvore do Hexagonix. Todos os repositórios com códigos de terceiros devem ser clonados no interior do diretório `Contrib`. `Contrib.sh`é responsável por construir e/ou manipular os códigos de terceiros, como aplicativos e bibliotecas.
* configure.sh: Deve estar no diretório raiz da árvore de construção. Ele é responsável por criar arquivos estáticos necessários à construção do Hexagonix. Sua execução pode ser iniciada pelo `HX`, caso os arquivos estáticos necessários não sejam localizados.

</div>

</details>

</details>

<details title="English" align='left'>
<summary align='left'><strong>:uk: English</strong></summary>

### Tools for building Hexagonix

<div align="justify">

This repository contains tools to build Hexagonix and the system disk images, in addition to allowing you to test it in a virtual machine, applying all the necessary parameters.

</div>

<details title="HX" align='left'>
<br>
<summary align='center'>HX</summary>

<p align="center">
<img width="150px" height="150px" src="https://github.com/hexagonix/Doc/blob/main/Img/HX.png">
</p>

<div align="justify">

`HX` is the tool responsible for unifying all the construction of Hexagonix, creating disk images and running tests in a virtual machine. `HX` accepts a number of parameters to customize the system build and testing environment. The `HX` must be in the root directory of the Hexagonix build tree. See below for some of the accepted parameters.

* `-i`: Create a disk image containing Hexagonix. This parameter takes a second, specifying the image type. The default secondary parameter for `-i` is `hx`, as in `hx -i hx`. This option creates a standard Hexagonix disk image, built from the default settings. Use `hx -h` for more information.
* `-v`: Starts a virtual environment to run Hexagonix on `qemu`. This parameter needs a second, specifying the virtual environment to use. The default secondary parameter for `-v` is `hx`, as in `hx -v hx`. This option starts a virtual machine with default settings. Use `hx -h` for more information.
* `-c`: Clears object files from the system font tree. Use `hx -h` for more information.
* `-h`: Displays the standard `HX` help, with all available options.

</div>

</details>

<details title="Other Tools" align='left'>
<br>
<summary align='center'>Other tools</summary>

<div align="justify">

* Contrib.sh: must be in the `Contrib` directory, at the root of the Hexagonix tree. All repositories with third party code must be cloned inside the `Contrib` directory. `Contrib.sh` is responsible for building and/or manipulating third-party code, such as applications and libraries.
* configure.sh: Must be in the root directory of the build tree. He is responsible for creating static files needed to build Hexagonix. Its execution can be started by `HX`, in case the necessary static files are not found.

</div>

</details>

</details>

<details title="Scripts License" align='left'>
<br>
<summary align='left'>Licença dos scripts/Scripts License</summary>

<div align="justify">

Hexagonix Operating System

BSD 3-Clause License

Copyright (c) 2015-2024, Felipe Miguel Nery Lunkes<br>
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

</div>

</details>

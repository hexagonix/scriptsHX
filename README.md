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

</div>

<hr>

# English

### Tools for building Hexagonix

<div align="justify">

This repository contains tools to build Hexagonix and the system disk images, in addition to allowing you to test it in a virtual machine, applying all the necessary parameters.

</div>

<details title="HX" align='left'>
<br>
<summary align='left'><strong>HX</strong></summary>

<p align="center">
<img src="https://github.com/hexagonix/Doc/blob/main/Img/HX.png">
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
<summary align='left'><strong>Other tools</strong></summary>

<div align="justify">

* Externos.sh: must be in the `Externos` directory, at the root of the Hexagonix tree. All repositories with third party code must be cloned inside the `Externos` directory. `Externos.sh` is responsible for building and/or manipulating third-party code, such as applications and libraries.
* configure.sh: Must be in the root directory of the build tree. He is responsible for creating static files needed to build Hexagonix. Its execution can be started by `HX`, in case the necessary static files are not found.

</div>

</details>

<hr>

# Português

### Ferramentas para construção do Hexagonix

<div align="justify">

Este repositório contém ferramentas para construir o Hexagonix e as imagens de disco do sistema, além de permitir testá-lo em uma máquia virtual, aplicando todos os parâmetros necessários.

</div>

<details title="HX" align='left'>
<br>
<summary align='left'><strong>HX</strong></summary>

<p align="center">
<img weight= "150px" src="https://github.com/hexagonix/Doc/blob/main/Img/HX.png">
</p>

<div align="justify">

O `HX` é a ferramenta responsável por unificar toda a construção do Hexagonix, criação de imagens de disco e execução de testes em uma máquina virtual. O `HX` aceita uma série de parâmetros para personalizar a construção do sistema e o ambiente de testes. O `HX`deve estar no diretório raiz da árvore de construção do Hexagonix. Veja abaixo alguns dos parâmetros aceitos.

* `-i`: Criar uma imagem de disco contendo o Hexagonix. Esse parâmetro necessita de um segundo, especificando o tipo de imagem. O parâmetro secundário padrão para `-i`é `hx`, como em `hx -i hx`. Essa opção cria uma imagem de disco padrão do Hexagonix, construído com as definições padrão. Use `hx -h`para mais informações.
* `-v`: Inicia um ambiente virtual para executar o Hexagonix no `qemu`. Esse parâmetro necessita de um segundo, especificando o ambiente virtual a ser utilizado. O parâmetro secundário padrão para `-v`é `hx`, como em `hx -v hx`. Essa opção inicia uma máquina virtual com as definições padrão. Use `hx -h`para mais informações.
* `-c`: Limpa os arquivos objeto da árvore de fontes do sistema. Use `hx -h`para mais informações.
* `-h`: Exibe a ajuda padrão do `HX`, com todas as opções disponíveis.

</div>

</details>

<details title="Outras ferramentas" align='left'>
<br>
<summary align='left'><strong>Outras ferramentas</strong></summary>

<div align="justify">

* Externos.sh: deve estar no diretório `Externos`, na raiz da árvore do Hexagonix. Todos os repositórios com códigos de terceiros devem ser clonados no interior do diretório `Externos`. `Externos.sh`é responsável por construir e/ou manipular os códigos de terceiros, como aplicativos e bibliotecas.
* configure.sh: Deve estar no diretório raiz da árvore de construção. Ele é responsável por criar arquivos estáticos necessários à construção do Hexagonix. Sua execução pode ser iniciada pelo `HX`, caso os arquivos estáticos necessários não sejam localizados.

</div>

</details>

<!--

Versão deste arquivo: 1.0

-->

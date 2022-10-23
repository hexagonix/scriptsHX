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

# Scripts para geração do Hexagonix

Este repositório contém os shell scripts necessários para construir o sistema e as imagens de disco do Hexagonix, além de permitir testar o sistema em uma máquia virtual, fornecendo todos os parâmetros necessários.

# Informação de localização na árvore de construção do Hexagonix:

<div align="justify">

Este repositório não é necessário para a construção do Hexagonix. Ele serve apenas para armazenar os scripts de construção que por sua vez serão utilizados no processo. Para isso, verifique abaixo a localização de cada script, que deve ser copiado para as localizações adequadas ao iniciar uma nova árvore de construção local:

* Externos.sh[^1]: deve estar no diretório Externos, na raiz da árvore. Todos os repositórios com códigos de terceiros devem ser clonados no interior do diretório Externos
* configure.sh: Deve estar no diretório raiz da árvore de construção
* hx: Deve estar no diretório raiz da árvore de construção

[^1]: Script responsável por construir e/ou manipular os códigos de terceiros, como aplicativos e bibliotecas, que devem estar na pasta Externos, na raiz da árvore de construção do sistema.

</div>

Versão deste arquivo: 1.0

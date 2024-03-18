#!/bin/bash
#
#*************************************************************************************************
#
# 88                                                                                88
# 88                                                                                ""
# 88
# 88,dPPPba,   ,adPPPba, 8b,     ,d8 ,adPPPPba,  ,adPPPb,d8  ,adPPPba,  8b,dPPPba,  88 8b,     ,d8
# 88P'    "88 a8P     88  `P8, ,8P'  ""     `P8 a8"    `P88 a8"     "8a 88P'   `"88 88  `P8, ,8P'
# 88       88 8PP"""""""    )888(    ,adPPPPP88 8b       88 8b       d8 88       88 88    )888(
# 88       88 "8b,   ,aa  ,d8" "8b,  88,    ,88 "8a,   ,d88 "8a,   ,a8" 88       88 88  ,d8" "8b,
# 88       88  `"Pbbd8"' 8P'     `P8 `"8bbdP"P8  `"PbbdP"P8  `"PbbdP"'  88       88 88 8P'     `P8
#                                               aa,    ,88
#                                                "P8bbdP"
#
#                    Sistema Operacional Hexagonix - Hexagonix Operating System
#
#                         Copyright (c) 2015-2024 Felipe Miguel Nery Lunkes
#                        Todos os direitos reservados - All rights reserved.
#
#*************************************************************************************************
#
# Português:
#
# O Hexagonix e seus componentes são licenciados sob licença BSD-3-Clause. Leia abaixo
# a licença que governa este arquivo e verifique a licença de cada repositório para
# obter mais informações sobre seus direitos e obrigações ao utilizar e reutilizar
# o código deste ou de outros arquivos.
#
# English:
#
# Hexagonix and its components are licensed under a BSD-3-Clause license. Read below
# the license that governs this file and check each repository's license for
# obtain more information about your rights and obligations when using and reusing
# the code of this or other files.
#
#*************************************************************************************************
#
# BSD 3-Clause License
#
# Copyright (c) 2015-2024, Felipe Miguel Nery Lunkes
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# $HexagonixOS$

# $PORTUGUÊS$
#
# Esse script deve ficar na raiz do projeto
#
# $ENGLISH$
#
# This script must be in the root of the project

optimizeFontsManualsAndDefinitions()
{

optimizeFonts
optimizeManuals
optimizeDefinitions

}

optimizeFonts()
{

echo -e "> \e[32mSearching and fixing indentation in Hexagonix source and related files...\e[0m"

find . -name '*.asm' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;
find . -name '*.s' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;
find . -name '*.cow' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;

echo -e "> \e[32mSearching and removing extra spaces in Hexagonix source and related files...\e[0m"

find . -name '*.asm' ! -type d -exec bash -c 'sed -i "s/[[:blank:]]\{1,\}$//" "$0"' {} \;
find . -name '*.s' ! -type d -exec bash -c 'sed -i "s/[[:blank:]]\{1,\}$//" "$0"' {} \;
find . -name '*.cow' ! -type d -exec bash -c 'sed -i "s/[[:blank:]]\{1,\}$//" "$0"' {} \;

}

optimizeDefinitions()
{

echo -e "> \e[32mSearching and fixing indentation in Hexagonix definition files...\e[0m"

find . -name '*.conf' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;
find . -name '*.def' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;

echo -e "> \e[32mSearching and removing extra spaces in Hexagonix definition files...\e[0m"

find . -name '*.conf' ! -type d -exec bash -c 'sed -i "s/[[:blank:]]\{1,\}$//" "$0"' {} \;
find . -name '*.def' ! -type d -exec bash -c 'sed -i "s/[[:blank:]]\{1,\}$//" "$0"' {} \;

}

optimizeManuals()
{

echo -e "> \e[32mSearching and fixing indentation in Hexagonix manuals...\e[0m"

find . -name '*.man' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;

echo -e "> \e[32mSearching and removing extra spaces in Hexagonix manuals...\e[0m"

find . -name '*.man' ! -type d -exec bash -c 'sed -i "s/[[:blank:]]\{1,\}$//" "$0"' {} \;

}

optimizeScripts()
{

echo -e "> \e[32mSearching and fixing indentation in Hexagonix scripts and tools...\e[0m"

find . -name '*.sh' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;
find . -name 'hx' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;

echo -e "> \e[32mSearching and removing extra spaces in Hexagonix scripts and tools...\e[0m"

find . -name '*.sh' ! -type d -exec bash -c 'sed -i "s/[[:blank:]]\{1,\}$//" "$0"' {} \;
find . -name 'hx' ! -type d -exec bash -c 'sed -i "s/[[:blank:]]\{1,\}$//" "$0"' {} \;

echo -e "> \e[32mTuning executable and script files...\e[0m"

find . -name '*.sh' ! -type d -exec bash -c 'chmod +x *.sh' {} \;
find . -name 'hx' ! -type d -exec bash -c 'chmod +x hx' {} \;

}

indentHelp()
{

echo
echo -e "\e[1;94mMain\e[0m available parameters:"
echo
echo -e "\e[1;32m-a\e[0m - Indent and optimize Hexagonix source files, manuals and definition files."
echo -e "\e[1;32m-f\e[0m - Indent and optimize Hexagonix x86 Assembly source files only."
echo -e "\e[1;32m-m\e[0m - Indent and optimize Hexagonix manuals only."
echo -e "\e[1;32m-d\e[0m - Indent and optimize Hexagonix definition files only."
echo -e "\e[1;32m-s\e[0m - Indent and optimize Hexagonix scripts and build tools only."
echo -e "\e[1;32m-h\e[0m - Display this help."
echo

}

showVersion()
{
echo "hx build module for source indentation, version $INDENT_VERSION"
echo
echo -e "\e[0mCopyright (c) 2015-2024 Felipe Miguel Nery Lunkes\e[0m"
echo -e "hx and hx modules are licensed under BSD-3-Clause and comes with no warranty."
}

export INDENT_VERSION="4.0.0"

echo
echo "hx indentation helper version $INDENT_VERSION"
echo
echo "This tool looks for and fixes indentation and formatting problems in the files"
echo "that make up the Hexagonix project."
echo

case $1 in

# Manage parameters starting with '-'

-a) optimizeFontsManualsAndDefinitions; exit;;
-f) optimizeFonts; exit;;
-m) optimizeManuals; exit;;
-d) optimizeDefinitions; exit;;
-s) optimizeScripts; exit;;
-h) indentHelp; exit;;
--version) showVersion; exit;;
*) indentHelp; exit;;

esac
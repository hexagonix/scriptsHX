#!/bin/bas

find ./ -iname *.asm -type f -exec bash -c expand -t 4 "$0" | sponge "$0" {} ;

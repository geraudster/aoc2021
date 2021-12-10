#!/usr/bin/env bash

input=$1

while IFS= read -r line; do
    echo $line | /usr/share/antlr4/grun Solution expr 2>&1 | cut -f5 -d' ' | tr -d "'" | head -n 1 -
done < $input | sed "s/)/3/;s/\]/57/;s/\}/1197/;s/>/25137/" | paste -s -d+ - | bc

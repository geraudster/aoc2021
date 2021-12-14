#!/usr/bin/env bash

input=$1

template=$(head -n 1 $input)

echo $template
echo
echo -n "CREATE "
tail +3 $input | sed -r 's/([A-Z])([A-Z]) -> ([A-Z])/\1\n\2\n\3/' | sort -u | sed -r 's/(.)/(\1:Template {name:"\1"})/' | tr '\n' ','
tail +3 $input | sed -r 's/(.)(.) -> (.)/(\1)-[:FOLLOWED_BY]->(\2)-[:TRANSFORMS_INTO]->(\3)/' | tr '\n' ',' | sed 's/,$//'
echo
echo

#!/usr/bin/env bash

input_file=$1

echo -n "create "
(< $input_file tr '-' '\n' | sort -u | sed -r 's/([a-z]+)/(\1:Cave {name: "\1", size: "small"})/; t; s/([A-Z]+)/(\1:Cave {name: "\1", size: "big"})/; t'
sed -r 's/^(.+)-(.+)$/(\1)-[:GOTO]->(\2),(\2)-[:GOTO]->(\1)/' $input_file) | tr '\n' ',' | sed 's/,$/\n/'

cat <<EOF

MATCH path=(start:Cave {name: "start"})-[*1..20]-(end:Cave {name: "end"})
WHERE NONE (n IN nodes(path)
              WHERE n.size = "small" AND
              size([x IN nodes(path)
                       WHERE n = x])> 1)
RETURN DISTINCT [n IN nodes(path) | n.name]



#MATCH (start:Cave {name: "start"})
#MATCH (end:Cave {name: "end"})
#CALL apoc.path.expandConfig(start, {maxLevel: 10, terminatorNodes: [end], uniqueness: 'NONE'})
#YIELD path
#WHERE NONE (n IN nodes(path)
#              WHERE n.size = "small" AND
#              size([x IN nodes(path)
#                       WHERE n = x])> 1)
#RETURN DISTINCT [n IN nodes(path) | n.name]
#
#MATCH (start:Cave {name: "start"})
#MATCH (end:Cave {name: "end"})
#CALL apoc.algo.allSimplePaths(start, end, 'GOTO', 10)
#YIELD path
#WHERE NONE (n IN nodes(path)
#              WHERE n.size = "small" AND
#              size([x IN nodes(path)
#                       WHERE n = x])> 1)
#RETURN DISTINCT [n IN nodes(path) | n.name]

EOF

cat <<EOF

docker run -p7474:7474 -p7687:7687 -e NEO4J_AUTH=neo4j/s3cr3t -e NEO4JLABS_PLUGINS=\[\"apoc\"\] neo4j
http://localhost:7474

EOF

#!/bin/bash

# start neo4j container
i=1
while [ $i -lt 3 ]
do
	docker rm -f core$i &> /dev/null
	docker rm -f replica$i &> /dev/null

	echo "start core$i container..."
	docker run -itd --net=neo4j \
                -p $(( $i  ))7474:7474 \
                -p $(( $i  ))7687:7687 \
                --name core$i --hostname core$i qiuyuhang/neo4j-cluster &> /dev/null

	docker exec -itd core$i bash -c "bash ~/configure.sh core $i && bash /opt/neo4j/bin/neo4j start && sleep 100000"
	
	echo "start replica$i container..."
	docker run -itd --net=neo4j \
			-p $(( $i + 2 ))7474:7474 \
			-p $(( $i + 2 ))7687:7687 \
				 --name replica$i --hostname replica$i qiuyuhang/neo4j-cluster &> /dev/null
	
	docker exec -itd replica$i bash -c "bash ~/configure.sh replica $i && bash /opt/neo4j/bin/neo4j start && sleep 100000"
	
	i=$(( $i + 1 ))
done 

# get into neo4j master container
docker exec -it core1 bash
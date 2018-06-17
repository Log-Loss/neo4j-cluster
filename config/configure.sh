#!/bin/bash
#  >> /opt/neo4j/conf/neo4j.conf
echo dbms.connectors.default_listen_address=0.0.0.0 >> /opt/neo4j/conf/neo4j.conf
echo causal_clustering.initial_discovery_members=core1:5000,core2:5000,core3:5000  >> /opt/neo4j/conf/neo4j.conf
if [ $1 == "core" ] 
	then
		echo dbms.connectors.default_advertised_address=core$2 >> /opt/neo4j/conf/neo4j.conf
		echo dbms.mode=CORE >> /opt/neo4j/conf/neo4j.conf
	else
		echo dbms.mode=READ_REPLICA >> /opt/neo4j/conf/neo4j.conf
fi
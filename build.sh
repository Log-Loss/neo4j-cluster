#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
 docker build -t qiuyuhang/neo4j-cluster .

echo ""
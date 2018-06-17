FROM ubuntu

MAINTAINER qiuyuhang <imqyh@qq.com>

WORKDIR /root

COPY config /tmp/

RUN tar xzvf /tmp/neo4j-enterprise.tar.gz && mv neo4j-enterprise* /opt/neo4j && mv /tmp/configure.sh ~ && rm -rf /tmp/*

RUN  echo export PATH=/opt/neo4j/bin:$PATH  >> .bashrc 

RUN apt update && apt install zsh openjdk-8-jdk git vim -y

CMD [ "sh", "-c", "service ssh start; bash"]
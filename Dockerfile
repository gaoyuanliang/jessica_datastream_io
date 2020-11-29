############Dockerfile###########
FROM openjdk:8

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y git 
RUN apt-get install -y curl
RUN apt-get install -y vim
RUN apt-get install -y tar

RUN apt-get install -y python3-dev
RUN apt-get install -y python3-pip

######

RUN mkdir /jessica/
RUN chmod 777 /jessica/ 

RUN useradd -u 8877 jessica
USER jessica

###downalod the kibana and elasticsearch files

WORKDIR /jessica/
RUN wget https://artifacts.elastic.co/downloads/kibana/kibana-5.6.1-linux-x86_64.tar.gz
RUN tar xvzf kibana-5.6.1-linux-x86_64.tar.gz

WORKDIR /jessica/
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.1.tar.gz
RUN tar xvzf elasticsearch-5.6.1.tar.gz

EXPOSE 5601/tcp
EXPOSE 9200/tcp

####configur
RUN echo "server.port: 5601" > /jessica/kibana-5.6.1-linux-x86_64/config/kibana.yml
RUN echo "server.host: \"0.0.0.0\"" >> /jessica/kibana-5.6.1-linux-x86_64/config/kibana.yml

RUN echo "transport.host: localhost" > /jessica/elasticsearch-5.6.1/config/elasticsearch.yml
RUN echo "transport.tcp.port: 9300" >> /jessica/elasticsearch-5.6.1/config/elasticsearch.yml
RUN echo "http.port: 9200" >> /jessica/elasticsearch-5.6.1/config/elasticsearch.yml
RUN echo "network.host: 0.0.0.0" >> /jessica/elasticsearch-5.6.1/config/elasticsearch.yml

####
USER root
WORKDIR /jessica/
RUN pip3 install -e git+https://github.com/gaoyuanliang/datastream.io#egg=dsio
RUN pip3 install bokeh==1.0.1
RUN pip3 install tornado==4.5.3

USER jessica
WORKDIR /jessica/src/dsio

############Dockerfile###########

# Pull base image.
FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y wget default-jre

# Install ElasticSearch.
ENV es_version 1.2.4

RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$es_version.tar.gz && \
  tar xvzf elasticsearch-$es_version.tar.gz && \
  rm -f elasticsearch-$es_version.tar.gz && \
  mv /tmp/elasticsearch-$es_version /elasticsearch

WORKDIR /elasticsearch

# Plugins
RUN /elasticsearch/bin/plugin \
  -i com.github.chytreg/elasticsearch-analysis-morfologik/2.3.1

RUN /elasticsearch/bin/plugin \
    -i com.github.richardwilly98.elasticsearch/elasticsearch-river-mongodb/2.0.1

# Define mountable directories.
VOLUME ["/elasticsearch/data"]

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# HTTP API
EXPOSE 9200 
# Transport
EXPOSE 9300

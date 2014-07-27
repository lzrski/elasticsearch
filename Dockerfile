#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y wget default-jre

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.0.tar.gz && \
  tar xvzf elasticsearch-1.1.0.tar.gz && \
  rm -f elasticsearch-1.1.0.tar.gz && \
  mv /tmp/elasticsearch-1.1.0 /elasticsearch

# Define working directory.
WORKDIR /elasticsearch

ADD elasticsearch-analysis-morfologik-2.1.zip /elasticsearch/

RUN /elasticsearch/bin/plugin \
  -u file:///elasticsearch/elasticsearch-analysis-morfologik-2.1.zip \
  -i analysis-morfologik

RUN /elasticsearch/bin/plugin \
    -i elasticsearch/marvel/latest

RUN /elasticsearch/bin/plugin \
    -i com.github.richardwilly98.elasticsearch/elasticsearch-river-mongodb/2.0.0

# Define mountable directories.
VOLUME ["/elasticsearch/data"]

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

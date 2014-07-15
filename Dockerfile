#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM dockerfile/java

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz && \
  tar xvzf elasticsearch-1.1.1.tar.gz && \
  rm -f elasticsearch-1.1.1.tar.gz && \
  mv /tmp/elasticsearch-1.1.1 /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

ADD elasticsearch-analysis-morfologik-2.1.jar /
RUN \
  /elasticsearch/bin/plugin \
    -u file:///elasticsearch-analysis-morfologik-2.1.jar \
    -i elasticsearch-analysis-morfologik

RUN \
  /elasticsearch/bin/plugin \
    -i elasticsearch/marvel/latest

RUN \
  /elasticsearch/bin/plugin \
    -i com.github.richardwilly98.elasticsearch/elasticsearch-river-mongodb/2.0.0

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

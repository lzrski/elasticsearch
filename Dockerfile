FROM dockerfile/elasticsearch

# Plugins
RUN /elasticsearch/bin/plugin \
  -i com.github.chytreg/elasticsearch-analysis-morfologik/2.3.1

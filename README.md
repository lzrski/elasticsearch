## ElasticSearch Dockerfile

With following plugins installed:

  * [Morfologik Analysis](https://github.com/monterail/elasticsearch-analysis-morfologik)

### Installation

Install [Docker](https://www.docker.io/).

### Usage

    docker run -d -p 9200:9200 -p 9300:9300 --link mongo:mongo --name elasticsearch lzrski/elasticsearch

#### Attach persistent/shared directories

  1. Create a mountable data directory `<data-dir>` on the host.

  2. Create ElasticSearch config file at `<data-dir>/elasticsearch.yml`.

    ```yml
    path:
      logs: /data/log
      data: /data/data
    ```

  3. Start a container by mounting data directory and specifying the custom configuration file:

    ```sh
    docker run -d -p 9200:9200 -p 9300:9300 -v <data-dir>:/data lzrski/elasticsearch /elasticsearch/bin/elasticsearch -Des.config=/data/elasticsearch.yml
    ```

After few seconds, open `http://<host>:9200` to see the result.

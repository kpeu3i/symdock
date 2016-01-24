FROM elasticsearch:1.7

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./elasticsearch/1.7/scripts /scripts/elasticsearch
COPY ./elasticsearch/1.7/elasticsearch.yaml /usr/share/elasticsearch/config/elasticsearch.yaml

RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yaml

CMD ["sh", "-c", "/scripts/elasticsearch/start.sh ; elasticsearch"]
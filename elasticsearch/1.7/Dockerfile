FROM elasticsearch:1.7

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./elasticsearch/1.7/scripts /scripts/elasticsearch
COPY ./elasticsearch/1.7/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yml

ENTRYPOINT ["sh", "-c"]

CMD ["/scripts/elasticsearch/start.sh"]

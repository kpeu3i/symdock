FROM ruby:2.3

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./fluentd/latest/file.conf /fluentd/etc/file.conf
COPY ./fluentd/latest/elasticsearch.conf /fluentd/etc/elasticsearch.conf

RUN mkdir -p /fluentd/log /fluentd/etc /fluentd/plugins

RUN gem install fluentd -v 0.12.19 && \
    gem install fluent-plugin-elasticsearch && \
    gem install fluent-plugin-parser

CMD ["fluentd", "-c", "/fluentd/etc/elasticsearch.conf", "-p", "/fluentd/plugins"]

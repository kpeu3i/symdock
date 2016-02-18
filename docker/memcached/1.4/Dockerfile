FROM memcached:1.4

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./memcached/1.4/scripts /scripts/memcached

ENTRYPOINT ["sh", "-c"]

CMD ["/scripts/memcached/start.sh"]

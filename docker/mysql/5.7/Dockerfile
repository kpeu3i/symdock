FROM mysql:5.7

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./mysql/5.7/scripts /scripts/mysql
COPY ./mysql/5.7/default.cnf /etc/mysql/conf.d/default.cnf

RUN chown -R mysql:mysql /var/run/mysqld

RUN apt-get update && apt-get install -y pv

ENTRYPOINT ["sh", "-c"]

CMD ["/scripts/mysql/start.sh"]

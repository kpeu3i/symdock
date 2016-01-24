FROM mysql:5.7

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./mysql/5.7/scripts /scripts/mysql
COPY ./mysql/5.7/default.cnf /etc/mysql/conf.d/default.cnf

RUN usermod -u 1000 mysql
RUN chown -R mysql:mysql /var/run/mysqld

CMD ["sh", "-c", "/scripts/mysql/start.sh ; mysqld"]

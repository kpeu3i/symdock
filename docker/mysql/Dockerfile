FROM mysql

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./default.cnf /etc/mysql/conf.d/default.cnf

RUN usermod -u 1000 mysql
RUN chown mysql /var/run/mysqld

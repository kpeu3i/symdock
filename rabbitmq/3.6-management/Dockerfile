FROM rabbitmq:3.6-management

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./rabbitmq/3.6-management/scripts /scripts/rabbitmq

CMD ["sh", "-c", "/scripts/rabbitmq/start.sh ; rabbitmq-server"]

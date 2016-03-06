FROM node:wheezy

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./node/wheezy/scripts /scripts/node

ARG SYMDOCK_SSH_PUBLIC_KEY
ARG SYMDOCK_SSH_PRIVATE_KEY

RUN mkdir -p /var/www/.ssh
RUN bash -c 'echo -e "$SYMDOCK_SSH_PRIVATE_KEY" > /var/www/.ssh/id_rsa'

WORKDIR /var/www/symfony

CMD ["sh", "-c", "/scripts/node/start.sh ; node"]

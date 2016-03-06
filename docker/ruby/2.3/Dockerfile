FROM ruby:2.3

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./ruby/2.3/scripts /scripts/ruby

ARG SYMDOCK_SSH_PUBLIC_KEY
ARG SYMDOCK_SSH_PRIVATE_KEY

RUN gem install capifony

RUN mkdir -p /var/www/.ssh
RUN bash -c 'echo -e "$SYMDOCK_SSH_PRIVATE_KEY" > /var/www/.ssh/id_rsa'

WORKDIR /var/www/symfony

CMD ["sh", "-c", "/scripts/ruby/start.sh ; irb"]

FROM ruby:2.3

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./ruby/2.3/scripts /scripts/ruby

RUN gem install capifony

WORKDIR /var/www/symfony

CMD ["sh", "-c", "/scripts/ruby/start.sh ; irb"]

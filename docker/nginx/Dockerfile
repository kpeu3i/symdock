FROM nginx

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./entrypoint.sh /entrypoint.sh
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./upstream.conf /etc/nginx/conf.d/upstream.conf
COPY ./symfony.conf /etc/nginx/sites-enabled/symfony.conf

RUN usermod -u 1000 www-data
RUN rm -f /etc/nginx/conf.d/default.conf
RUN mkdir -p /var/lib/nginx/body /var/lib/nginx/proxy /var/lib/nginx/fastcgi /var/lib/nginx/scgi /var/lib/nginx/uwsgi

ENTRYPOINT ["/entrypoint.sh"]
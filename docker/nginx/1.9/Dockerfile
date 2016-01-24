FROM nginx:1.9

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./nginx/1.9/scripts /scripts/niginx
COPY ./nginx/1.9/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/1.9/upstream.conf /etc/nginx/conf.d/upstream.conf
COPY ./nginx/1.9/symfony.conf /etc/nginx/sites-enabled/symfony.conf

RUN rm -f /etc/nginx/conf.d/default.conf
RUN mkdir -p /var/lib/nginx/body /var/lib/nginx/proxy /var/lib/nginx/fastcgi /var/lib/nginx/scgi /var/lib/nginx/uwsgi

CMD ["sh", "-c", "/scripts/nginx/start.sh ; nginx -g 'daemon off;'"]
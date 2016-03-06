FROM kibana:4.1

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./kibana/4.1/scripts /scripts/kibana
COPY ./kibana/4.1/kibana.yml /opt/kibana/config/kibana.yml

CMD ["sh", "-c", "/scripts/kibana/start.sh ; kibana"]

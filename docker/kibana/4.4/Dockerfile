FROM kibana:4.4

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./kibana/4.4/scripts /scripts/kibana
COPY ./kibana/4.4/kibana.yml /opt/kibana/config/kibana.yml

RUN kibana plugin --install elastic/sense

CMD ["sh", "-c", "/scripts/kibana/start.sh ; kibana"]
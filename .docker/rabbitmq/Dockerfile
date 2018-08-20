FROM rabbitmq:3.6.9
MAINTAINER Dana Negrescu <dana.negrescu@evozon.com>

RUN apt-get install -yqq \
    rabbitmq-server \
    && apt-get clean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/man \
    /usr/share/doc \
    /usr/share/doc-base

RUN rabbitmq-plugins enable rabbitmq_mqtt rabbitmq_stomp rabbitmq_management rabbitmq_management_agent rabbitmq_management_visualiser rabbitmq_federation rabbitmq_federation_management sockjs

COPY ./bin/start.sh /usr/local/bin/rabbitmq/start.sh
RUN chmod +x /usr/local/bin/rabbitmq/start.sh

# AMQP port and Management interface, epmd port, and the inet_dist_listen_min through inet_dist_listen_max ranges
EXPOSE 5672 15672 4369 9100 9101 9102 9103 9104 9105

ENTRYPOINT ["/usr/local/bin/rabbitmq/start.sh"]
CMD ["rabbitmq-server"]

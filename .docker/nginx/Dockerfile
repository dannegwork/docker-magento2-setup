FROM nginx:1.15
MAINTAINER Dana Negrescu <dana.negrescu@boxalino.com>

RUN apt-get update && apt-get install -y \
    curl \
    nano \
    procps \
    iputils-ping


COPY conf /etc/nginx/
COPY conf /usr/local/bin/nginx/sites-enabled/default.m2.conf
COPY bin /usr/local/bin/start.sh

COPY ssl/* /etc/nginx/ssl/

RUN chmod +x /usr/local/bin/start.sh

WORKDIR /var/www/magento
EXPOSE 80 443

CMD ["/usr/local/bin/start.sh"]
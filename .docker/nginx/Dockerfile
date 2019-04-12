FROM nginx:1.15
MAINTAINER Dana Negrescu <dana.negrescu@boxalino.com>

RUN apt-get update && apt-get install -y \
    curl \
    nano \
    procps \
    iputils-ping


COPY conf /etc/nginx/
COPY conf/sites-enabled /usr/local/bin/nginx/sites-enabled/

WORKDIR /var/www/magento
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
FROM docker.elastic.co/elasticsearch/elasticsearch:5.5.2
MAINTAINER Lilian Codreanu <lilian.codreanu@evozon.com>

COPY config/elasticsearch.yml /usr/share/elasticsearch/config/
COPY bin/docker-entrypoint.sh /usr/share/elasticsearch

USER root

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.10
RUN set -ex; \
	\
	yum -y install epel-release; \
	yum -y install wget dpkg; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /tmp/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
    # verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /tmp/gosu.asc /usr/bin/gosu; \
	rm -r "$GNUPGHOME" /tmp/gosu.asc; \
	\
	chmod +x /usr/bin/gosu; \
    # verify that the binary works
	gosu nobody true; \
	\
	yum -y remove wget dpkg; \
	yum clean all

RUN mkdir -p /var/logs/elasticsearch/logserver && \
    mkdir -p /var/data/elasticsearch/logserver

RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yml

RUN chmod +x /usr/share/elasticsearch/docker-entrypoint.sh

VOLUME /var/logs/elasticsearch/logserver
VOLUME /var/data/elasticsearch/logserver

EXPOSE 9200 9300
ENTRYPOINT ["/usr/share/elasticsearch/docker-entrypoint.sh"]
CMD ["elasticsearch"]

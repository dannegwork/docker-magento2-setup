FROM php:7.0.20-cli
MAINTAINER Dana Negrescu <dana.negrescu@evozon.com>

# # Install dependencies
RUN apt-get update \
   && apt-get install -y \
     cron \
     rsyslog \
     libfreetype6-dev \
     libicu-dev \
     libjpeg62-turbo-dev \
     libmcrypt-dev \
     libpng12-dev \
     libxslt1-dev \
     libmcrypt-dev \
     libxml2-dev \
     mysql-client \
     libssh2-1-dev \
     libssh2-php \
     git \
     sendmail-bin \
     sendmail \
     php-xml-dtd

 # Configure the gd library
RUN docker-php-ext-configure \
   gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

 # Install required PHP extensions
RUN docker-php-ext-install \
   gd \
   intl \
   bcmath \
   mbstring \
   mcrypt \
   pdo_mysql \
   xsl \
   zip \
   json \
   iconv \
   soap

#Installing SSH2
RUN pecl channel-update pecl.php.net
 RUN apt-get install -y git libssh2-1 libssh2-1-dev && \
    pecl install ssh2-1.0 && \
    docker-php-ext-enable ssh2

# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY .composer/auth.json /root/.composer/auth.json

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libmemcached-dev \
    libmemcached11

#Adding memcached library, fittable with/for PHP7
RUN git clone -b php7 https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
 && docker-php-ext-configure /usr/src/php/ext/memcached \
     --disable-memcached-sasl \
 && docker-php-ext-install /usr/src/php/ext/memcached \
 && rm -rf /usr/src/php/ext/memcached

ADD bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/environment
RUN chmod +x /usr/local/bin/install

WORKDIR /var/www/magento

RUN usermod -u 1000 www-data
RUN usermod -G 100 www-data

ENTRYPOINT ["/usr/local/bin/environment"]
#CMD ["bash"]
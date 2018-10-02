FROM php:7.0.20-fpm
MAINTAINER Dana Negrescu <dana.negrescu@boxalino.com>

# install libs according to Magento2 documentation&requirements
RUN apt-get update && apt-get install -y \
    cron \
    libmemcached-dev \
    libssl-dev \
    libz-dev \
    libmemcached11 \
    libmcrypt-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libfreetype6-dev \
    libpq-dev \
    zlib1g-dev \
    libicu-dev \
    libxslt-dev \
    libjpeg-dev \
    libssl-dev \
    libmcrypt-dev \
    libxml2-dev \
    curl \
    ssh \
    libssh2-1-dev \
    libssh2-php \
    vim \
    git \
    openssl \
    sendmail-bin \
    sendmail\
    g++

#Adding memcached library, fittable with/for PHP7
RUN git clone -b php7 https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
 && docker-php-ext-configure /usr/src/php/ext/memcached \
     --disable-memcached-sasl \
 && docker-php-ext-install /usr/src/php/ext/memcached \
 && rm -rf /usr/src/php/ext/memcached

# Install and configure libraries and extensions
RUN docker-php-ext-install mcrypt \
  && docker-php-ext-install pdo_mysql \
  && docker-php-ext-install pdo_pgsql \
  && docker-php-ext-configure intl \
  && docker-php-ext-configure hash --with-mhash

RUN docker-php-ext-configure \
   gd --with-freetype-dir=/usr/local/ --with-jpeg-dir=/usr/local/

# Install required extensions
RUN docker-php-ext-install \
    bcmath \
    gd \
    mbstring \
    intl \
    xsl \
    zip \
    json \
    iconv \
    soap

COPY ./conf/php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./conf/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
#Installing SSH2
RUN pecl channel-update pecl.php.net
RUN apt-get install -y git libssh2-1 libssh2-1-dev && \
  pecl install ssh2-1.0 && \
  docker-php-ext-enable ssh2

# Install OPCache
RUN docker-php-ext-install opcache && \
    docker-php-ext-enable opcache

# Install Xdebug
RUN pecl install xdebug && \
docker-php-ext-enable xdebug

# Install Redis for PHP:
RUN pecl install redis-3.1.2 \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

RUN apt-get update &&\
    apt-get -y install build-essential ruby-full libsqlite3-dev &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* &&\
    gem install mailcatcher --no-rdoc --no-ri

# Configure app folder
ENV WORK_DIR ${WORK_DIR:-/www/magento}
WORKDIR $WORK_DIR

VOLUME "/usr/local/etc/php/conf.d"

RUN usermod -u 1001 www-data
EXPOSE 9000

CMD ["php-fpm"]

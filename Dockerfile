# use a module of apache for php 7.1
FROM php:7.1-apache

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# install modules of apache that will be required
RUN apt-get update && apt-get install -y \
  bzip2 \
  libcurl4-openssl-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg-dev \
  libldap2-dev \
  libmcrypt-dev \
  libmemcached-dev \
  libpng12-dev \
  libpq-dev \
  libxml2-dev \
&& rm -rf /var/lib/apt/lists/*
# https://docs.nextcloud.com/server/9/admin_manual/installation/source_installation.html
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
&& docker-php-ext-install gd exif intl mbstring mcrypt ldap mysqli opcache pdo_mysql pdo_pgsql pgsql zip

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=60'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
  } > /usr/local/etc/php/conf.d/opcache-recommended.ini
RUN a2enmod rewrite

# PECL extensions
RUN set -ex \
 && pecl install APCu-5.1.8 \
 && pecl install memcached-3.0.2 \
 && pecl install redis-3.1.1 \
 && docker-php-ext-enable apcu redis memcached
RUN a2enmod rewrite

ENV NEXTCLOUD_VERSION 11.0.2

# Setup apache configurations for nextcloud
COPY nextcloud.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/nextcloud.conf /etc/apache2/sites-enabled/nextcloud.conf
RUN a2enmod ssl

# Remove APT files
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

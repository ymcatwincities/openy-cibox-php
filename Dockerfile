FROM php:7.4.16-apache

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libcurl4-openssl-dev \
    libmagickwand-dev \
    libmemcached-dev \
    libedit-dev \
    libzip-dev \
    git \
    rsync \
    && apt-get -y clean && apt-get -y autoclean && pecl install imagick memcached \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd 
RUN  docker-php-ext-enable imagick \
    && a2enmod rewrite \
    && docker-php-ext-enable  memcached \
    && docker-php-ext-install -j$(nproc) soap \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) opcache
RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory_limit.ini

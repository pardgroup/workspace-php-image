FROM phusion/baseimage:latest

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

# Add the PHP ppa
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php

# Install "PHP Extentions", "libraries", "Software's"
RUN apt-get update && \
    apt-get install -y --allow-downgrades --allow-remove-essential \
        --allow-change-held-packages \
        php7.3-cli \
        php7.3-common \
        php7.3-curl \
        php7.3-intl \
        php7.3-json \
        php7.3-xml \
        php7.3-mbstring \
        mcrypt \
        php7.3-mysql \
        php7.3-zip \
        php7.3-bcmath \
        php7.3-memcached \
        php7.3-cgi \
        php7.3-gd \
        php7.3-dev \
        php7.3-bz2 \
        pkg-config \
        libcurl4-openssl-dev \
        libedit-dev \
        libssl-dev \
        libxml2-dev \
        xz-utils \
        git \
        curl \
        vim \
        php-imagick \
        apt-utils \
        libzip-dev zip unzip \
        nasm && \
        php -m | grep -q 'zip' \
    && apt-get autoremove -y \
    && apt-get clean

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

# Install mcrypt for dependencies
RUN apt-get -y install libmcrypt-dev && \
  pecl install mcrypt-1.0.2

COPY configuration/php.ini /usr/local/etc/php/php.ini

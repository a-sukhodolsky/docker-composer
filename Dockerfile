FROM php:7.3-cli

MAINTAINER Alexander Sukhodolsky <asvira.net@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get upgrade -y && \
    apt-get install -y zip unzip libzip-dev wget && \
    docker-php-ext-install zip && \
    apt-get autoremove -y && \
    apt-get clean && rm -r /var/lib/apt/lists/*

# Install composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /opt/bin:/root/.composer/vendor/bin:${PATH}
RUN mkdir -p /opt/bin && \
    curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/opt/bin --filename=composer && \
    composer global require consolidation/cgr && \
    composer clear-cache

RUN mkdir -p /app

WORKDIR /app

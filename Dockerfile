FROM phusion/baseimage:jammy-1.0.0

LABEL maintainer="Ralph Schindler"

# Generally don't override these
ENV COMPOSER_HOME="/root/.composer" \
    COMPOSER_ALLOW_SUPERUSER=1 \
    PATH="$PATH:/app/vendor/bin:/app:/app/node_modules/.bin:." \
    PHP_IDE_CONFIG="serverName=localhost" \
    TERM="xterm-256color"

# Environment variables to be overridden if needed
ENV APP_NAME="elephantbox-app" \
    APP_ENV="production" \
    MY_INIT_COMMAND="my_init --quiet" \
    PHP_FPM_INI_MEMORY_LIMIT="128M" \
    PHP_FPM_INI_OPCACHE_BLACKLIST_FILENAME="/etc/php/opcache-blacklist.enabled" \
    PHP_FPM_INI_POST_MAX_SIZE="10M" \
    PHP_FPM_INI_UPLOAD_MAX_FILESIZE="10M" \
    PHP_FPM_CONF_PM="dynamic" \
    PHP_FPM_CONF_PM_MAX_CHILDREN="5"

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-add-repository -y ppa:ondrej/php \
    && install_clean \
        git \
        libpng-dev \
        mysql-client \
        nano \
        nginx \
        nodejs \
        php-pear \
        php8.1-ast \
        php8.1-bcmath \
        php8.1-cli \
        php8.1-common \
        php8.1-curl \
        php8.1-decimal \
        php8.1-enchant \
        php8.1-fpm \
        php8.1-gd \
        php8.1-gnupg \
        php8.1-grpc \
        php8.1-http \
        php8.1-imagick \
        php8.1-imap \
        php8.1-intl \
        php8.1-ldap \
        php8.1-mbstring \
        php8.1-mysql \
        php8.1-pgsql \
        php8.1-protobuf \
        php8.1-pspell \
        php8.1-readline \
        php8.1-redis \
        php8.1-soap \
        php8.1-sqlite \
        php8.1-ssh2 \
        php8.1-tidy \
        php8.1-xdebug \
        php8.1-xml \
        php8.1-xmlrpc \
        php8.1-yaml \
        php8.1-zip \
        postgresql-client \
        tzdata \
        unzip \
        yarn \
    && rm /etc/php/8.1/*/conf.d/20-xdebug.ini \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 80

COPY docker/ /

ENTRYPOINT ["/usr/local/bin/entrypoint"]

CMD ["/bin/true"]

WORKDIR /app

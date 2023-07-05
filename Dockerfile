FROM phusion/baseimage:jammy-1.0.1 AS phpext

RUN install_clean ca-certificates \
    && apt-add-repository -y ppa:ondrej/php \
    && install_clean \
        pkg-config \
        php8.2-dev \
        git \
        make \
        unzip

COPY ./docker/usr/local/src /usr/local/src

RUN /usr/local/src/install-php-extensions-from-source.sh

##
## Image Start
##
FROM phusion/baseimage:jammy-1.0.1

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

RUN curl -sL https://deb.nodesource.com/setup_19.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-add-repository -y ppa:ondrej/php \
    && install_clean \
        git \
        libpng-dev \
        imagemagick \
        jq \
        mysql-client \
        nano \
        nginx \
        nodejs \
        php-pear \
        php8.2-ast \
        php8.2-bcmath \
        php8.2-cli \
        php8.2-common \
        php8.2-curl \
        php8.2-decimal \
        php8.2-enchant \
        php8.2-fpm \
        php8.2-gd \
        php8.2-gnupg \
        php8.2-grpc \
        php8.2-http \
        php8.2-imagick \
        php8.2-imap \
        php8.2-intl \
        php8.2-ldap \
        php8.2-mbstring \
        php8.2-mysql \
        php8.2-pgsql \
        php8.2-protobuf \
        php8.2-pspell \
        php8.2-raphf \
        php8.2-readline \
        php8.2-redis \
        php8.2-soap \
        php8.2-sqlite \
        php8.2-ssh2 \
        php8.2-tidy \
        php8.2-xdebug \
        php8.2-xml \
        php8.2-xmlrpc \
        php8.2-yaml \
        php8.2-zip \
        postgresql-client \
        tzdata \
        unzip \
        yarn \
    && rm /etc/php/8.2/*/conf.d/20-xdebug.ini \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY --from=phpext /usr/lib/php/20220829/dio.so /usr/lib/php/20220829/dio.so

# disable syslog in phusion
RUN chmod 644 /etc/my_init.d/10_syslog-ng.init

EXPOSE 80

COPY docker/ /

ENTRYPOINT ["/usr/local/bin/entrypoint"]

CMD ["/bin/true"]

WORKDIR /app

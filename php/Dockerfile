FROM php:8.1.11-fpm

RUN apt-get update && apt-get install -y wget cron supervisor libzip-dev zip libpq-dev libpng-dev

RUN docker-php-ext-install zip pdo pgsql pdo_pgsql mysqli pdo_mysql gd

RUN pecl install xdebug && docker-php-ext-enable xdebug

# Create the log file
RUN touch /var/log/schedule.log
RUN chmod 0777 /var/log/schedule.log

# Add crontab file in the cron directory
ADD scheduler /etc/cron.d/scheduler

# Run the cron
RUN crontab /etc/cron.d/scheduler

# Copy supervisor configs
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install Node
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Install Dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Install Composer
COPY --from=composer:2.4.0 /usr/bin/composer /usr/bin/composer

COPY php_conf.ini /usr/local/etc/php/conf.d/990-custom.ini

# ARG PHP_SECURITY_CHECKER_HASH="90cc98e306a91d5a3fa3ccdf20e428e21a8e62cc8a8994863c34e864475bbf1e"
# ARG PHP_SECURITY_CHECKER_VERSION="2.0.6"
# RUN wget "https://github.com/fabpot/local-php-security-checker/releases/download/v${PHP_SECURITY_CHECKER_VERSION}/local-php-security-checker_${PHP_SECURITY_CHECKER_VERSION}_linux_386" -nv -O local-php-security-checker \
#   && echo "${PHP_SECURITY_CHECKER_HASH}  local-php-security-checker" | sha256sum -c - \
#   && chmod +x local-php-security-checker \
#   && mv local-php-security-checker /usr/local/bin/local-php-security-checker

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
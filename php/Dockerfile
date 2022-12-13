FROM php:8.1.11-fpm

RUN apt-get update && apt-get install -y wget cron supervisor libzip-dev zip libpq-dev libpng-dev

RUN docker-php-ext-install zip pdo pgsql pdo_pgsql mysqli pdo_mysql gd

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

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY --from=composer:2.4.0 /usr/bin/composer /usr/bin/composer

RUN pecl install xdebug && docker-php-ext-enable xdebug

COPY php_conf.ini /usr/local/etc/php/conf.d/990-custom.ini
 
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
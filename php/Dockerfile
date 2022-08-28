FROM php:8.0.5-fpm

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
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs build-essential

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY --from=composer:2.4.0 /usr/bin/composer /usr/bin/composer

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
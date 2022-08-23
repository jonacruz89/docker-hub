FROM php:8.0.5-fpm

RUN apt-get update && apt-get install -y cron supervisor libzip-dev zip libpq-dev libpng-dev

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

RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs build-essential

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
FROM nginx:latest

COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./default.conf.template /etc/nginx/conf.d/default.conf.template

CMD /bin/bash -c "envsubst '\$APP_FASTCGI_PASS' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf \
                  && exec nginx -g 'daemon off;'"
FROM node:lts-alpine

# Install the packages we need
RUN apk add --no-cache \
    git \
    nano \
    nginx \
    openssl \
    supervisor \
    unzip \
    wget \
    zip

RUN adduser -D -g 'www' www

RUN mkdir -p /var/log/nginx && \
    mkdir -p /var/log/supervisor

RUN rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/* /var/tmp/*


# Copy nginx config
RUN mkdir -p /var/www/dummy /var/www/html
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/default-site.conf /etc/nginx/sites-available/default
COPY config/nginx/conf.d/. /etc/nginx/conf.d/
COPY config/nginx/snippets/. /etc/nginx/snippets/

RUN chown -R www:www /var/lib/nginx && \
    chown -R www:www /var/www/dummy && \
    chown -R www:www /var/www/html


# Copy suporvisor config
COPY config/supervisor/supervisord.conf /etc/supervisord.conf


# Add an SSL certificate for *.localhost
COPY config/ssl/localhost.ext /etc/ssl/localhost.ext
RUN openssl req -x509 \
    -out /etc/ssl/localhost.crt \
    -keyout /etc/ssl/localhost.key \
    -newkey rsa:2048 -nodes -sha256 -days 1024 \
    -subj "/C=NL/ST=Zuid-Holland/O=Localhost/CN=localhost" \
    -extensions EXT \
    -config /etc/ssl/localhost.ext


#
# Install Gulp globally
#
RUN yarn global add @vue/cli @vue/cli-service-global gulp-cli gulp


WORKDIR /var/www/html
EXPOSE 80 443


# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
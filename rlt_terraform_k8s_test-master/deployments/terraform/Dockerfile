FROM php:7.4.3-apache
COPY source/ /var/www/html/
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
EXPOSE 80

# FROM php:7.4.3-apache
# COPY . /app
# RUN chown -R www-data:www-data /app && a2enmod rewrite
# EXPOSE 80

# FROM php:7.4-cli
# COPY . /usr/src/myapp
# WORKDIR /usr/src/myapp
# CMD [ "php", "./index.php" ]
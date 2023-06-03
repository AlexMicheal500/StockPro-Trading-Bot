FROM wordpress:6.1.1
COPY wp-content/ /var/www/html/wp-content/
COPY wp-config.php /var/www/html
ARG old_url=default
ARG dev_url=http://new_ip

#Installation of MariaDB and Wp-CLI
RUN apt-get update -y && apt-get install mariadb-client -y && apt-get install git -y && apt-get install rsync -y && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp 


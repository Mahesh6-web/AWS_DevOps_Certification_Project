FROM devopsedu/webapp:latest
COPY website/ /var/www/html/

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

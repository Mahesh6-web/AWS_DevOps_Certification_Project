FROM devopsedu/webapp:latest

COPY website/ /var/www/html/

# Start Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

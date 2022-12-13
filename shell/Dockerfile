FROM debian:bullseye
RUN apt-get update
RUN apt-get install apache2 vim -y
RUN a2enmod cgid
COPY ./docker/script.cgi /usr/lib/cgi-bin/script.cgi
RUN chmod +x /usr/lib/cgi-bin/script.cgi
RUN service apache2 restart
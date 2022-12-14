FROM sebp/lighttpd
# install dependencies
RUN apk update
RUN apk add gcc libc-dev
# copy scripts folder
COPY ./scripts /scripts
# compile the C program
RUN gcc /scripts/script.c -o /scripts/script_c.cgi
# copy lighttpd config file
COPY ./lighttpd.conf /etc/lighttpd/lighttpd.conf
# create CGI script folder
RUN mkdir /var/www/cgi-bin -p
# copy the scripts
RUN cp /scripts/script_c.cgi /var/www/cgi-bin/script_c.cgi
RUN cp /scripts/script.sh /var/www/cgi-bin/script_sh.cgi
# grant execute permission
RUN chmod +x /var/www/cgi-bin/script_c.cgi
RUN chmod +x /var/www/cgi-bin/script_sh.cgi
# remove the unused folder
RUN rm -rf /scripts
# copy the index
COPY ./index.html /var/www/index.html
# init the webserver
CMD ["sh", "/usr/local/bin/start.sh"]
# Rust build stage
FROM rust:alpine AS rust
COPY ./scripts/script.rs /script
RUN cd /script && cargo build --release

FROM sebp/lighttpd
# install dependencies
RUN apk update
# install C
RUN apk add gcc libc-dev
# install C# (.NET 6)
RUN apk add dotnet6-sdk
# install Python 3
RUN apk add python3
# install Perl
RUN apk add perl
# install Ruby
RUN apk add ruby
# install Lua
RUN apk add lua5.3
# install PHP
RUN apk add php
# copy scripts folder
COPY ./scripts /scripts
# create CGI script folder
RUN mkdir /var/www/localhost/cgi-bin -p
# compile the C program
RUN gcc /scripts/script.c -o /scripts/script.cgi
# compile the C# program
RUN dotnet build /scripts/script.cs -o /var/www/localhost/cgi-bin/script_csharp
# copy executable compiled from build stage
COPY --from=rust ./script/target/release /var/www/localhost/cgi-bin/script_rust
# copy lighttpd config file
COPY ./lighttpd.conf    /etc/lighttpd/lighttpd.conf
COPY ./mod_cgi.conf     /etc/lighttpd/mod_cgi.conf
# copy the scripts
RUN cp /scripts/script.cgi  /var/www/localhost/cgi-bin/script.cgi
RUN cp /scripts/script.lua  /var/www/localhost/cgi-bin/script.lua
RUN cp /scripts/script.php  /var/www/localhost/cgi-bin/script.php
RUN cp /scripts/script.pl   /var/www/localhost/cgi-bin/script.pl
RUN cp /scripts/script.py   /var/www/localhost/cgi-bin/script.py
RUN cp /scripts/script.rb   /var/www/localhost/cgi-bin/script.rb
RUN cp /scripts/script.sh   /var/www/localhost/cgi-bin/script.sh
# grant execute permission
RUN chmod g+x /var/www/localhost/cgi-bin/script.cgi
RUN chmod g+x /var/www/localhost/cgi-bin/script.lua
RUN chmod g+x /var/www/localhost/cgi-bin/script.php
RUN chmod g+x /var/www/localhost/cgi-bin/script.pl
RUN chmod g+x /var/www/localhost/cgi-bin/script.py
RUN chmod g+x /var/www/localhost/cgi-bin/script.rb
RUN chmod g+x /var/www/localhost/cgi-bin/script.sh
# remove the unused folder
RUN rm -rf /scripts
# copy the index
COPY index.html /var/www/localhost/htdocs/index.html
COPY console.html /var/www/localhost/htdocs/console.html
COPY console.sh /var/www/localhost/cgi-bin/console.sh
RUN chmod g+x /var/www/localhost/cgi-bin/console.sh
# init the webserver
CMD ["sh", "/usr/local/bin/start.sh"]
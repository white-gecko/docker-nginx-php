FROM debian:jessie

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
    apt-get install -y nginx-light supervisor
RUN apt-get install -y php5-fpm php5-curl

RUN rm -r /var/lib/apt/lists/*

RUN sed -i "1idaemon off;" /etc/nginx/nginx.conf
ADD nginx-default.conf /etc/nginx/sites-enabled/default

VOLUME /var/www/html
EXPOSE 80

ADD supervisor.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]

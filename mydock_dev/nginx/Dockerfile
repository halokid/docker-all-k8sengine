FROM hub.c.163.com/library/nginx:1.9

ADD  nginx.conf      /etc/nginx/nginx.conf

#下面这句出了问题，导致容器启动不了，稍后再看看
ADD  sites-enabled/*    /etc/nginx/conf.d/

RUN  mkdir /opt/htdocs && mkdir /opt/log && mkdir /opt/log/nginx
RUN  chown -R www-data.www-data /opt/htdocs /opt/log

EXPOSE 80
VOLUME ["/opt"]


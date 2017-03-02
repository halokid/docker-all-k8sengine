pull:
	docker pull hub.c.163.com/library/nginx:1.9
	docker pull hub.c.163.com/library/php:5.6-fpm 
	docker pull hub.c.163.com/library/mysql:5.6
	docker pull hub.c.163.com/library/redis:3.0
	docker pull hub.c.163.com/library/memcached:1.4

dl:
	wget --no-check-certificate https://github.com/phalcon/cphalcon/archive/1.3.5.tar.gz -O php/cphalcon.tgz
	wget --no-check-certificate https://pecl.php.net/get/redis-2.2.7.tgz -O php/redis.tgz
	wget --no-check-certificate https://pecl.php.net/get/memcached-2.2.0.tgz -O php/memcached.tgz
	wget --no-check-certificate https://pecl.php.net/get/xdebug-2.3.2.tgz -O php/xdebug.tgz
	wget --no-check-certificate https://pecl.php.net/get/msgpack-0.5.6.tgz -O php/msgpack.tgz
	wget --no-check-certificate https://pecl.php.net/get/memcache-2.2.7.tgz -O php/memcache.tgz
	wget --no-check-certificate https://pecl.php.net/get/xhprof-0.9.4.tgz -O php/xhprof.tgz
	wget --no-check-certificate https://getcomposer.org/composer.phar -O php/composer.phar

build:
	make build-nginx
	make build-mysql
	make build-php
	make build-node

build-nginx:
	docker build -t dev/nginx ./nginx

run-nginx:
	docker run -i -d -p 80:80 -v /root/opt:/opt -t dev/nginx

in-nginx:
	docker run -i -p 80:80 -v /root/opt:/opt -t dev/nginx /bin/bash

build-php:
	docker build -t dev/php ./php

run-php:
	docker run -i -d -p 9000:9000 -v /root/opt:/opt -t dev/php

in-php:
	docker run -i -p 9000:9000 -v /root/opt:/opt -t dev/php /bin/bash

build-mysql:
	docker build -t dev/mysql ./mysql

run-mysql:
	docker run -i -d -p 3306:3306 -v /root/opt/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t dev/mysql

in-mysql:
	docker run -i -p 3306:3306  -v /root/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t dev/mysql /bin/bash



clean:
	docker rmi -f $(shell docker images | grep "<none>" | awk "{print \$3}")




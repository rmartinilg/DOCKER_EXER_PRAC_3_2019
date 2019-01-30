#!/bin/bash
echo "Borrado de contenedores"
docker rm -f httpd
docker rm -f nginx
docker rm -f datacontainer
docker rm -f mariadb
echo "borrados"

docker run --name datacontainer -d -v wordpress:/var/www/html -v wordpress:/var/lib/mysql/ centos

docker run --name mariadb -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mariadb -e MYSQL_DATABASE1=wordpress_db -e MYSQL_USER1=moodle -e MYSQL_PASSWORD1=moodle --volumes-from datacontainer orboan/dcsss-mariadb

docker run --name nginx --link mariadb:mariadb --hostname nginx -p 8085:80 -d --volumes-from datacontainer nginx

wget http://wordpress.org/latest.tar.gz

tar -xzvf latest.tar.gz

docker cp wordpress datacontainer:/var/www/html


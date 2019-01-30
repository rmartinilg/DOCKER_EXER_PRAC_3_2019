#!/bin/bash
echo "Borrado de contenedores"
docker rm -f httpd
docker rm -f nginx
docker rm -f datacontainer
docker rm -f apache2

echo "borrados"

echo "contenedor x2"
docker create --name datacontainer -v DataVolume:/usr/share/nginx/html -v  DataVolume:/var/www/html ubuntu 

docker cp rmc.html datacontainer:/usr/share/nginx/html/
docker cp rmc.html datacontainer:/var/www/html/

docker run --name nginx  -p 8085:80 -d --volumes-from datacontainer nginx

docker run --name httpd -p 8086:80 -d --volumes-from datacontainer rmartinilg/centos-httpd-php-rmartinilg

echo "terminado press 'enter' para salir"
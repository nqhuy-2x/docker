####Triển khai mô hình LAMP trên docker####

#Tạo container php
docker run -d --name bkacad-php -h bkacad-php -v /home/vagrant/sitesdata/bkacad-code:/home/bkacad-code php:7.3-fpm
docker exec -it bkacad-php bash
php -v
cd /home/bkacad-code
echo "<?php echo 'Hello World!'; ?>" > test.php
php test.php

#Cai extension de ket noi php den mysql
docker-php-ext-install mysqli
#Cai them pdo_mysql extension 
docker-php-ext-install pdo_mysql

#Copy file php.ini-production thanh php.ini
cd /usr/local/etc/php/
cp php.ini-production php.ini
exit
docker restart bkacad-php 

#Cai dat container Apache
docker run -d --name bkacad-apache -h bkacad-httpd -v /home/vagrant/sitesdata/bkacad-code:/home/bkacad-code -p 8080:80 -p 443:443 httpd

#Thiet lap php handle
docker exec -it bkacad-apache bash
apt-get update -y && apt-get install vim -y && apt-get install iputils-ping -y
cd conf
vim httpd.conf

DocumentRoot "/home/bkacad-code"
<Directory "/home/bkacad-code">

LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so
AddHandle "proxy:fcgi://bkacad-php:9000" .php 

apachectl -k restart
exit

#Ket noi container php va apache vao network bkacad-network
docker network connect bkacad-network1 bkacad-php
docker network connect bkacad-network1 bkacad-apache
docker inspect bkacad-network1

#Test apache va php
cd /home/vagrant/sitesdata/bkacad-code
vim info.php 
<?php
   phpinfo();

192.168.12.10:8080/info.php

#Tao mysql container
docker run -it -d --name bkacad-mysql -h bkacad-mysql -v /home/vagrant/sitesdata/bkacad-code:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=abcd.1234 -p 3030:3306 mysql:5.7
docker network connect bkacad-network1 bkacad-mysql

mysql -h 172.18.0.4 -u root -pabcd.1234
create user 'admin'@'%' identified by 'abcd.1234';
create database db_test;
grant all privileges on db_test.* to 'admin'@'%';
flush privileges;
exit

#Tai wordpress ve thu muc bkacad-code
cd /home/vagrant/sitesdata/bkacad-code
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
mv wordpress/* .

mv wp-config-sample.php wp-config.php
vim wp-config.php
 #chinh sua thong tin dung voi thong tin da khai bao trong mysql

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'db_test' );

/** Database username */
define( 'DB_USER', 'admin' );

/** Database password */
define( 'DB_PASSWORD', 'abcd.1234' );

/** Database hostname */
define( 'DB_HOST', '172.18.0.4' );

#Truy cap wordpress
ip:8080/wp-admin
Dien cac thong so
http://192.168.12.10:8080/wp-admin/index.php









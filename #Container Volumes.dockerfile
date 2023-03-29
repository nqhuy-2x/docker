 #Container Volumes
#Managed by Docker in /var/lib/docker/volumes
#Stored anywhere on the host system
May host la he thong dang chay docker engine.
1 folder cua may host duoc chia se de cac container doc, luu du lieu

docker run -it -d --name bkacad-ubuntu -v /home/vagrant/sitesdata:/home/data ubuntu


touch data1.txt data2.txt datat3.txt

#Chia se du lieu giua cac container
docker run -it -d --name bkacad-nginx --volumes-from bkacad-ubuntu nginx

#Tao va chia se du lieu qua volume
docker volume ls
docker volume create bkacad-volume1
docker volume inspect bkacad-volume1
docker run -it -d --name bkacad-ubuntu2 --mount source=bkacad-volume1,target=/home/data2 ubuntu
docer exec -it bkacad-ubuntu2 /bin/bash
cd /home/data2
touch 1.txt index.php
exit
docker stop bkacad-ubuntu2
docker rm bkacad-ubuntu2
tao container bkacad-ubuntu3 va mount volume bkacad-volume1
check xem du lieu trong bkacad-ubuntu3 the nao

#Tao volume anh xa truc tiep den 1 folder tren may host
docker volume create --opt device=/home/vagrant/sitesdata --opt type=none --opt o=bind bkacad-volume2
docker run -it -d --name bkacad-ubuntu1 -v bkacad-volume2:/home/data ubuntu
docker run -it -d --name bkacad-ubuntu2 -v bkacad-volume2:/home/data ubuntu


###Docker network
Docker cho phep tao ra 1 network, giup cho lien ket cac container voi nhau sau khi ket noi chung vao chung 1 mang network.
Qua do, thong qua ten container va port.

#List network
docker network ls

docker run -it -d --name bkacad-busybox1 busybox
docker inspect bridge
docker run -it -d --name bkacad-busybox2 busybox
docker exec -it bkacad-busybox2 /bin/sh
cd war/www
httpd
vim index.html
exit
docker exec -it bkacad-busybox1 /bin/sh
wget -O - 172.17.0.3

docker run -it -d --name B2 -p 8888:80 busybox

#Tao 1 mang rieng
docker network create --driver bridge bkacad-network1
docker run -it -d --name bkacad-busybox3 --network bkacad-network1 busybox

#Ket noi container voi 1 network khac
docker network connect bridge bkacad-busybox3
docker inspect bridge
docker inspect bkacad-network1







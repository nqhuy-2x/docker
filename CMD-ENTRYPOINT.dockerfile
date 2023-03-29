#Tao cmd/Dockerfile
mkdir cmd
cd cmd
vim Dockerfile
FROM ubuntu:latest
CMD ["echo", "hello"]

docker build -t bkacad-printer1:v1 .
docker run bkacad-printer1

#Tao entrypoint/Dockerfile
mkidr entrypoint
cd entrypoint
vim Dockerfile
FROM ubuntu:latest
ENTRYPOINT ["echo"]

docker build -t bkacad-printer2:v1 .
docker run bkacad-printer2:v1 hello

#Tao entrypoint-cmd/Dockerfile
mkdir entrypoint-cmd
cd entrypoint-cmd
vim Dockerfile
FROM ubuntu:latest
ENTRYPOINT ["echo"]
CMD ["hello"]

#Sự khác nhau giữa RUN, CMD, ENTRYPOINT
RUN : được dùng khi muốn cài đặt gói bổ sung trong quá trình build images
Ví dụ : 
RUN apt-get update
RUN apt-get install httpd

CMD : cho biết lệnh nào được thực hiện mỗi khi khởi tạo container
Ví dụ :
CMD ["echo", "hello"]
CMD yum -y install vim && yum -y install nginx

ENTRYPOINT : dùng khi muốn container như 1 lệnh thực thi
Ví dụ :
ENTRYPOINT ["echo"]

Khi dùng ENTRYPOINT và CMD cùng nhau, thì CMD được sử dụng như 1 cách xác định các tham số để ENTRYPOINT thực thi. Và nếu có tham số khác được truyền vào thì CMD sẽ bị ghi đè.
Ví dụ như bkacad-printer3

COPY : chỉ hỗ trợ copy từ đường dẫn local.
ADD : hỗ trợ copy tệp tin nén .tar và đường dẫn URL vào container.


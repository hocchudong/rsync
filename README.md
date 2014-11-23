Làm việc với rsync
=====
**Một chút sơ cua**
Rsync - "remote sync" là một công cụ giúp đồng bộ hóa từ xa và trên máy local. Công cụ này đồng bộ rất thông minh, nó chỉ đồng bộ những sự thay đổi trong file hay folder cần đồng bộ mà thôi, do đó tiết kiệm được tài nguyên cho hệ thống. <br>
Một cái hay của Rsync so với copy thông thường là nó có thể giữ nguyên được group, owner, và permissions của đối tượng sau khi đồng bộ.
###Cách sử dụng
Sau đây là 1 số cách sử dụng cơ bản đối với rsync
**Quy ước**
SRC = nguồn
DEST = đích
dir1 = folder nguồn
dir2 = forfer đích
#####1. Đồng bộ trên local
Đồng bộ toàn bộ nội dung trong dir1 sang dir2:

    rsync -r dir1/ dir2

Biến **-r** để đồng bộ thư mục. <br>
Hoặc với biến **-a**,  


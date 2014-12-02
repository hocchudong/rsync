Làm việc với rsync
=====
**Một chút sơ cua** <br>
Rsync - "remote sync" là một công cụ giúp đồng bộ hóa từ xa và trên máy local. Công cụ này đồng bộ rất thông minh, nó chỉ đồng bộ những sự thay đổi trong file hay folder cần đồng bộ mà thôi, do đó tiết kiệm được tài nguyên cho hệ thống. <br>
Một cái hay của Rsync so với copy thông thường là nó có thể giữ nguyên được group, owner, và permissions của đối tượng sau khi đồng bộ.
### Cách sử dụng
Sau đây là 1 số cách sử dụng cơ bản đối với rsync
##
**Quy ước** <br>
SRC = nguồn <br>
DEST = đích <br>
dir1 = folder nguồn <br>
dir2 = forfer đích
##
Cài đặt rất đơn giản, đối với Ubuntu:

    apt-get install rsync

##### 1. Đồng bộ hóa trên local
Đồng bộ toàn bộ nội dung trong dir1 sang dir2:

    rsync -r dir1/ dir2

Tham số **-r** để đồng bộ thư mục. <br>
Hoặc với **-a** 

    rsync -a dir1/ dir2
    
sẽ cho phép đồng bộ cả group, owner, và permissions của dir1 sang dir2. Tham số này được sử dụng phổ biến hơn.
##
Một **lưu ý quan trọng**: dấu "/" trong câu lệnh trên có nghĩa là chỉ đồng bộ nội dung trong dir1. Nếu không có dấu "/" này, hệ thống sẽ hiểu là lấy cả folder dir1, sau khi đồng bộ tại dir2 sẽ là dir2/dir1/{nội dung dir1} chứ không phải là dir2/{nội dung dir1}.
##
Rsync cung cấp biến **-n** để kiểm tra các tham số trước khi thực hiện lệnh, biến **-v** để hiển thị kết quả.<br>
Ví dụ:

    rsync -anv dir1/ dir2

Output:

    sending incremental file list
    ./
    file1
    file2
    file3
    file4
    file5
    file6
    file7
    file8
    . . .

Và output khi không có dấu "/":
    
    sending incremental file list
    ./
    dir1/file1
    dir1/file2
    dir1/file3
    dir1/file4
    dir1/file5
    dir1/file6
    dir1/file7
    dir1/file8
    . . .  

##### 2. Đồng bộ hóa từ xa
Chỉ có thể sử dụng rsync để đồng bộ hóa từ xa khi cả 2 máy đều đã cài SSH.
##
Cú pháp câu lệnh:

    rsync -a ~/dir1/ username@DEST_host:~/dir2

File sẽ được động bộ sau khi xác thực và nhập đúng password của username tại DEST_host.<br>
Ví dụ:

    rsync -a /root/dir1/ root@192.168.1.99:/var/cache/dir2

Cú pháp trên được gọi là "push" vì đẩy file từ local lên remote_host.
##
Cú pháp sau sẽ được gọi là "pull" do đồng bộ file từ remote_host về localhost (chỉ cần đổi lại vị trí của nguồn và đích):

    rsync -a username@DEST_host:~/dir1  ~/dir2

Giống như lệnh copy **cp**, thư mục nguồn luôn đặt trước thư mục đích.

##### 3. Một số tham số hữu dụng
**-z**: Dữ liệu trên đường truyền sẽ được nén lại. Có nghĩa là nén ở nguồn và giải nén ở đích, điều này giúp tiết kiệm băng thông khi phải đồng bộ một lượng dữ liệu lớn.
##
**-P**: Tham số này cung cấp một thanh hiện thỉ tiến trình chuyển file. Nó cho phép tiếp tục tiến trình khi bị gián đoạn. Điều này rất hữu dụng khi phải đồng bộ file lớn như file image chẳng hạn! <br>
Ví dụ:

    rsync -azP ~/dir1/ dir2

Output:

    sending incremental file list
    ./
    file1
           0 100%    0.00kB/s    0:00:00 (xfer#1, to-check=99/101)
    file10
           0 100%    0.00kB/s    0:00:00 (xfer#2, to-check=98/101)
    file100
           0 100%    0.00kB/s    0:00:00 (xfer#3, to-check=97/101)
    file11
           0 100%    0.00kB/s    0:00:00 (xfer#4, to-check=96/101)
    . . .

##
**--delete**: <br>
Nếu thư mục đích đã có dữ liệu thì theo mặc định, rsync sẽ giữ nguyên những dữ liệu đó trong thư mục đích. Như vậy thì 2 thư mục nguồn và đích sẽ không thực sự đồng bộ, tất nhiên là nếu người dùng muốn điều này thì lại là chuyện khác.
##
Để xóa toàn bộ dữ liệu trong thư mục đích khi thực hiện đồng bộ, sử dụng tùy chọn **--delete**. Cần thận trọng khi sử dụng tùy chọn này, nên test trước khi sử dụng để đề phòng mất dữ liệu.

    rsync -a --delete SRC DEST
##
**--exclude**: <br>
Tùy chọn này giống **--delete**, nhưng nó cho phép liệt kê những file hay thư mục muốn xóa chứ không xóa toàn bộ.

    rsync -a --exclude=file1,file2,flie3... SRC DEST

###
###
Trên đây là một số trường hợp thường dùng với rsync, có thể sử dụng lệnh man để biết thêm các tham số khác.

#### Update
Làm thế nào để hệ thống backup một cách tự động bằng rsync? <br>
Mặc định thì rsync không hỗ trợ đặt lịch tự động backup, do đó ta cần dùng một tool bổ trợ khác. <br>
Để giải quyết bài toán trên thì có thể chia ra thành 2 bài toán chi tiết hơn:
- Thứ nhất là làm thế nào để backup tự động sau một khoảng thời gian nhất định? Trả lời: Dùng crontab <br>
- Thứ hai là làm thế nào để backup tự động mỗi khi có dữ liệu được đẩy vảo thư mục chứa dữ liệu cần backup? Trả lời: Dùng incron. <br>

Cách dùng crontab: [**link**](https://help.ubuntu.com/community/CronHowto) <br>
Cách dùng incron: [**link**](http://www.cyberciti.biz/faq/linux-inotify-examples-to-replicate-directories/)

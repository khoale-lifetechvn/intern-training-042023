# Cách cài đặt
1. Chạy lệnh `docker-composer up`
2. Sau khi chạy xong, thì import file  [sql](https://github.com/khoale-lifetechvn/intern-training-042023/blob/loi.nguyen/loi.nguyen/country.sql) trong database **countries**
3. Run [localhost:3000](http://localhost:3000/)
## Mô tả
- `docker-compose.yml` này định nghĩa ba dịch vụ:
- `app`: chứa ứng dụng React
- `api`: chứa API (được xây dựng bằng Node.js)
- `mysql`: cơ sở dữ liệu MySQL
- Dịch vụ app được xây dựng từ Dockerfile trong thư mục ./client và được đặt tên là react-task/client.
- Ứng dụng được lắng nghe trên cổng 3000, và các tệp tin được mount vào container thông qua volumes.
- Tương tự, dịch vụ api được xây dựng từ Dockerfile trong thư mục ./server và được đặt tên là react-task/server. API được lắng nghe trên cổng 5000 và được định cấu hình thông qua các biến môi trường.
- Dịch vụ mysql sử dụng hình ảnh của MySQL 8.0 và được cấu hình để lưu trữ dữ liệu trong thư mục todo-mysql-data. Các tệp tin trong container cũng được mount vào volumes.
- Cuối cùng, tệp tin docker-compose.yml này định nghĩa một volume với tên todo-mysql-data.

[x] s 
[]d

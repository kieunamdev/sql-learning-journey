BUỔI 5 · HÀM CHUỖI VÀ NGÀY: LIKE, ILIKE, UPPER, CONCAT,
DATE_TRUNC, EXTRACT, AGE
5.1 Tìm các phim có title bắt đầu bằng 'A' (LIKE).

select f.title 
from film f 
where f.title like 'A%';

5.2 Tìm các phim có title chứa từ 'love' không phân biệt hoa thường (ILIKE).

select f.title 
from film f 
where f.title ilike '%love%';

5.3 Tìm các khách hàng có first_name kết thúc bằng 'a' hoặc có đúng 5 ký tự
(gợi ý: LIKE '____' hoặc LENGTH).

select c.first_name 
from customer c 
where c.first_name like '%a' or length(c.first_name ) = 5;

5.4 Hiển thị họ tên khách hàng dạng 'NGUYEN, An' hoặc dạng 'LAST_NAME, First_name':
dùng UPPER, LOWER, INITCAP, CONCAT hoặc toán tử ||.

select UPPER(c.last_name ) || ', ' || INITCAP(c.first_name ) as full_name
from customer c ;

5.5 Tạo cột email_domain bằng cách lấy phần sau dấu '@' của email
(gợi ý: SPLIT_PART hoặc SUBSTRING + POSITION), rồi đếm số khách hàng mỗi domain.

select split_part(c.email , '@' , 2) as emain_domain ,
		count(*) as total_email
from customer c 
group by 1;

5.6 Dùng LENGTH để tìm 10 phim có title dài nhất.

select f.title , length(f.title )
from film f 
order by length(f.title ) desc 
limit 10;


5.7 Doanh thu theo tháng: dùng DATE_TRUNC('month', payment_date).

select date_trunc('month', p.payment_date ) as month , sum(p.amount )
from payment p 
group by "month" ;

5.8 Số lượt thuê theo thứ trong tuần và theo giờ trong ngày
(EXTRACT(DOW FROM ...), EXTRACT(HOUR FROM ...)). Thứ nào thuê nhiều nhất?

-- theo thứ
SELECT EXTRACT(DOW FROM r.rental_date) AS dow,
       COUNT(r.rental_id) AS total_rental
FROM rental r
GROUP BY 1
ORDER BY total_rental DESC;

-- theo giờ
SELECT EXTRACT(HOUR FROM r.rental_date) AS hour,
       COUNT(r.rental_id) AS total_rental
FROM rental r
GROUP BY 1
ORDER BY 1;


5.9 Số lượt thuê và doanh thu theo năm-quý (EXTRACT(YEAR ...), EXTRACT(QUARTER ...)).

SELECT EXTRACT(YEAR FROM r.rental_date) AS yr,
       EXTRACT(QUARTER FROM r.rental_date) AS qtr,
       COUNT(r.rental_id) AS total_rental,
       SUM(p.amount) AS revenue
FROM rental r
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY 1, 2
ORDER BY 1, 2;

5.10 Tính thời gian thuê của mỗi lượt đã trả bằng AGE(return_date, rental_date),
rồi tính trung bình số ngày thuê (EXTRACT(EPOCH FROM ...) / 86400).

SELECT AVG(EXTRACT(EPOCH FROM AGE(r.return_date, r.rental_date)) / 86400) AS avg_rental_days
FROM rental r
WHERE r.return_date IS NOT NULL;
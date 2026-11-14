BUỔI 1 · HÀM TỔNG HỢP: COUNT, SUM, AVG, MIN, MAX, distinct

1.1 Đếm tổng số phim trong bảng film.

select count(*) as total_film
from film f ;

1.2 Đếm tổng số khách hàng, và số khách hàng đang active (active = 1).

select count(*) as total_customer , 
		count(*) filter(where c.active = 1) as total_customers_active
from customer c ;

1.3 Tính tổng doanh thu (SUM(amount)) của bảng payment.

select sum(p.amount )
from payment p ;


1.5 Tìm thời lượng (length) ngắn nhất và dài nhất trong bảng film.

select Min(f.length ) , max(f.length )
from film f ;

1.6 Có bao nhiêu giá trị rating khác nhau? Liệt kê chúng (DISTINCT).

select distinct f.rating 
from film f; 

1.7 Có bao nhiêu khách hàng KHÁC NHAU đã từng thuê phim? (COUNT(DISTINCT ...) trên rental)

select count(distinct(r.customer_id )) 
from rental r ;

1.8 Tính số tiền trung bình mỗi giao dịch thanh toán và số giao dịch có amount = 0.

SELECT
    AVG(p.amount) AS avg_payment,
    COUNT(*) FILTER (WHERE p.amount = 0) AS zero_payment_count
FROM payment p;

1.9 So sánh COUNT(*) và COUNT(return_date) trong bảng rental.
Hai kết quả có bằng nhau không? Giải thích bằng comment (gợi ý: NULL).

select count(*) , count(r.return_date)
from rental r ;


1.10 Tổng chi phí thay thế (replacement_cost) của toàn bộ phim rating 'R'.

select sum(f.replacement_cost )
from film f 
where f.rating = 'R';


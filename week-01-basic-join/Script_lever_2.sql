Mức 2: Hàm tổng hợp, GROUP BY, HAVING
Ôn lại COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING.

9 Đếm số phim theo từng rating. 

select f.rating  , count(f.title ) as "total film"
from film f 
group by f.rating ;

10 Tính rental_rate trung bình và length trung bình của toàn bộ phim. 

select avg(f.rental_rate ) as "mean rental rate" , avg(f.length ) as "mean length"
from film f ;

11 Tính tổng doanh thu (SUM(amount)) trong bảng payment. 

select sum(p.amount ) as "total sales"
from payment p ;

12 Tổng tiền mỗi khách hàng đã trả (customer_id, tổng tiền), sắp xếp giảm dần.

select p.customer_id , sum(p.amount)
from payment p 
group by p.customer_id ;

13 Chỉ giữ các khách hàng đã trả trên 150.
Gợi ý: having

select p.customer_id , sum(p.amount )
from payment p 
group by p.customer_id 
having sum(p.amount) > 150;

14 Số lượt thuê (rental) theo từng tháng.
Gợi ý: DATE_TRUNC('month', rental_date) hoặc extract

select date_trunc('month', r.rental_date ) as thang 
		, count(r.rental_id)
from rental r 
group by date_trunc('month', r.rental_date )
order by thang ;

select extract('month' from r.rental_date ) as thang 
		, count(r.rental_id)
from rental r 
group by extract('month' from r.rental_date )
order by thang ;


15 Với mỗi rating, tìm phim dài nhất và ngắn nhất.

select f.rating , min(f.length ) , max(f.length )
from film f 
group by f.rating ;

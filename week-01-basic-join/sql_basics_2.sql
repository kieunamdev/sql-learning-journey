BUỔI 2 · GROUP BY (1 cột, nhiều cột) + THỨ TỰ THỰC THI

2.1 Đếm số phim theo từng rating.

select rating , count(*) as total_film
from film f 
group by f.rating ;

2.2 Tính rental_rate trung bình theo từng rating.

select f.rating , avg(f.rental_rate )
from film f 
group by f.rating ;

2.3 Đếm số lượt thuê (rental) của mỗi khách hàng (customer_id), sắp xếp giảm dần.

select r.customer_id , count(*) as total_rental
from rental r 
group by r.customer_id 
order by total_rental desc;

2.4 Tổng tiền mỗi khách hàng đã trả; lấy Top 10 khách hàng chi nhiều nhất.

select p.customer_id , sum(p.amount ) as total_amount
from payment p 
group by p.customer_id 
order by total_amount desc
limit 10; 

2.5 Đếm số phim theo cặp (rating, rental_duration). (GROUP BY nhiều cột)

select f.rating , f.rental_duration , count(*)
from film f 
group by f.rating , f.rental_duration;



2.6 Với mỗi cửa hàng (store_id) và mỗi nhân viên (staff_id), tính tổng doanh thu
từ bảng payment (payment có staff_id; store lấy qua bảng staff).

select s.store_id , p.staff_id , sum(p.amount )
from payment p 
inner join staff s on p.staff_id = s.staff_id
group by s.store_id , p.staff_id ;



2.7 Với mỗi (rating, release_year), tính số phim, length trung bình, length dài nhất.

select f.rating , f.release_year  , count(*) , avg(f.length ) , max(f.length )
from film f 
group by f.rating , f.release_year ;

2.8 Tổng doanh thu theo từng ngày (CAST payment_date sang DATE hoặc DATE(payment_date)).
Sắp xếp theo ngày tăng dần.

select Date(p.payment_date ) , sum(p.amount )
from payment p 
group by Date(p.payment_date )
order by Date(p.payment_date );




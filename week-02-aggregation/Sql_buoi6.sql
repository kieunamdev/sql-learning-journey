BUỔI 6 · BÀI TỔNG HỢP: JOIN + GROUP BY + HAVING
(Có thể kết hợp CASE WHEN, hàm chuỗi/ngày đã học)

6.1 Số phim theo từng thể loại (film_category -> category).
Chỉ giữ thể loại có từ 60 phim trở lên, sắp xếp giảm dần.

select c."name" , count(fc.film_id ) as total_film
from film_category fc 
inner join category c on fc.category_id = c.category_id
group by c.category_id 
having count(fc.film_id ) >= 60
order by total_film desc;

6.2 Diễn viên đóng từ 35 phim trở lên: hiển thị họ tên đầy đủ và số phim.

select a.last_name || ' ' || a.first_name as full_name ,
		count(fa.film_id ) as total_film
from actor a 
inner join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id 
having count(fa.film_id ) >= 35;

6.3 Doanh thu theo quốc gia (payment -> customer -> address -> city -> country),
chỉ giữ quốc gia có doanh thu > 3000, sắp xếp giảm dần.

select c3.country , 
		sum(p.amount ) as total_amount
from payment p 
inner join customer c on p.customer_id = c.customer_id 
inner join address a on c.address_id = a.address_id 
inner join city c2 on a.city_id = c2.city_id 
inner join country c3 on c2.country_id = c3.country_id 
group by c3.country_id 
having sum(p.amount ) > 3000
order by total_amount desc;

6.4 Doanh thu theo thể loại (payment -> rental -> inventory -> film_category -> category).
Thể loại nào cao nhất?

select c."name" ,
		sum(p.amount ) as total_amount
from payment p 
inner join rental r on p.rental_id = r.rental_id
inner join inventory i on r.inventory_id = i.inventory_id 
inner join film_category fc on i.film_id = fc.film_id 
inner join category c on fc.category_id = c.category_id 
group by c.category_id 
order by total_amount desc
limit 1;

6.5 Báo cáo khách hàng: họ tên, email, thành phố, quốc gia, số lượt thuê, tổng chi tiêu;
chỉ giữ khách có >= 30 lượt thuê, lấy Top 20 theo tổng chi tiêu.

select c.first_name || ' ' || c.last_name as full_name ,
		c.email ,
		c2.city ,
		c3.country ,
		count(distinct r.rental_id  ) as total_rental,
		sum(p.amount ) as total_amount
from customer c 
inner join address a on c.address_id = a.address_id
inner join city c2 on a.city_id = c2.city_id
inner join country c3 on c2.country_id = c3.country_id
inner join rental r on c.customer_id = r.customer_id 
inner join payment p on r.rental_id = p.rental_id
group by c.customer_id , c2.city_id , c3.country_id 
having count(p.rental_id ) >= 30
order by total_amount desc
limit 20;


6.6 Số lượt thuê và doanh thu của mỗi cửa hàng theo từng tháng.

select i.store_id,
       date_trunc('month', p.payment_date) as thang,
       count(distinct r.rental_id) as so_luot_thue,
       sum(p.amount) as doanh_thu
from payment p
inner join rental r on p.rental_id = r.rental_id
inner join inventory i on r.inventory_id = i.inventory_id
group by i.store_id, date_trunc('month', p.payment_date)
order by i.store_id, thang;


6.7 Thời gian thuê trung bình (ngày) theo thể loại, chỉ tính lượt đã trả,
chỉ giữ thể loại có trung bình > 5 ngày.

select c."name" ,
		avg(extract(epoch from age(r.return_date , r.rental_date )) / 86400) as avg_rental
from rental r 
inner join inventory i on r.inventory_id = i.inventory_id
inner join film_category fc on i.film_id = fc.film_id 
inner join category c on fc.category_id = c.category_id 
where r.return_date is not null
group by c.category_id 
having avg(extract(epoch from age(r.return_date , r.rental_date )) / 86400) > 5;

6.8 Với mỗi rating, phân nhóm phim theo độ dài (CASE từ Buổi 4) và đếm số phim
của mỗi (rating, nhóm độ dài). Chỉ giữ nhóm có > 20 phim.

6.9 (Thử thách) Với mỗi khách hàng, tính tỷ lệ lượt thuê trả muộn
(thời gian thực tế thuê > rental_duration của phim), chỉ giữ khách có tỷ lệ > 50%.
Cần JOIN rental -> inventory -> film.

6.10 (Thử thách) Báo cáo "mini dashboard" một câu truy vấn: tổng doanh thu, số khách hàng,
số lượt thuê, doanh thu trung bình/lượt thuê, số lượt chưa trả.
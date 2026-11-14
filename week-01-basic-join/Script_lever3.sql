Mức 3: JOIN
Mở ER Diagram của schema public để xem quan hệ giữa các bảng trước khi viết.

16 Liệt kê title phim cùng tên ngôn ngữ.
Gợi ý: film JOIN language

select f.title , l."name" 
from film f 
join "language" l 
on f.language_id = l.language_id;


17 Liệt kê tên khách hàng cùng thành phố và quốc gia.
Gợi ý: customer → address → city → country

select c.last_name || ' ' || c.first_name as "customer_name" , c2.city  , c3.country 
from customer c 
join address a on c.address_id = a.address_id  
join city c2 on a.city_id = c2.city_id
join country c3 on c2.country_id = c3.country_id;

18 Liệt kê tên diễn viên và các phim họ đóng.
Gợi ý: actor → film_actor → film

select a.first_name  || ' ' || a.last_name as "actor_name",
		f.title 
from actor a 
join film_actor fa on a.actor_id = fa.actor_id 
join film f on f.film_id = fa.film_id ;

19 Số phim theo từng thể loại (category), sắp xếp giảm dần.
Gợi ý: film → film_category → category

select c."name", count(*) as total_film
from film_category fc
join category c on c.category_id = fc.category_id
group by c.category_id
order by total_film desc;

20 Top 10 khách hàng chi tiêu nhiều nhất, hiển thị họ tên đầy đủ và tổng tiền. 

select c.customer_id 
		, c.last_name || ' ' || c.first_name  as "full_name"
		, sum(p.amount ) as total
from customer c 
join payment p on c.customer_id = p.customer_id 
group by c.customer_id 
order by total desc 
limit 10 ;

21 Doanh thu theo từng cửa hàng (store).
Gợi ý: payment → staff → store, hoặc đi qua rental → inventory

select s.store_id, sum(p.amount) as revenue
from payment p
join staff s on p.staff_id = s.staff_id
group by s.store_id
order by s.store_id;

22 Top 5 diễn viên xuất hiện trong nhiều phim nhất. 

select a.first_name || ' ' || a.last_name as "actor_name" 
		, count(fa.film_id ) as "total_film"
from actor a 
join film_actor fa on a.actor_id = fa.actor_id 
group by a.actor_id 
order by total_film desc  
limit 5 ;

23 Tìm các phim chưa từng được thuê.
Gợi ý: LEFT JOIN + IS NULL (film → inventory → rental)

select f.title
from film f
left join inventory i on f.film_id = i.film_id
left join rental r on i.inventory_id = r.inventory_id
group by f.film_id
having count(r.rental_id) = 0;



24 Tìm khách hàng chưa từng thuê phim nào.

select c.first_name || ' ' || c.last_name as "full_name"
from customer c 
left join rental r on c.customer_id = r.customer_id
where r.rental_id is null;
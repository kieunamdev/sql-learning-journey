1 Lấy first_name, last_name, email của tất cả khách hàng (customer). 

select c.first_name , c.last_name , c.email 
from customer c ;

2 Liệt kê 10 phim có length dài nhất (title, length). 

select f.title , f.length 
from film f 
order by f.length desc 
limit 10 ;

3 Tìm các phim có rating = 'PG-13' và rental_rate < 3. 

select f.title , f.rating , f.rental_rate 
from film f 
where f.rating = 'PG-13' and f.rental_rate < 3 ;

4 Liệt kê các giá trị rating khác nhau trong bảng film. 

select distinct f.rating 
from film f ;

5 Tìm khách hàng có last_name bắt đầu bằng 'S' và active = 1.

select c.last_name , c.active 
from customer c 
where c.last_name like 'S%' and c.active = 1;

6 Tìm các phim có title chứa từ "LOVE" (không phân biệt hoa thường).
Gợi ý: ilike

select f.title
from film f
where f.title ilike '%LOVE%';

7 Lấy các khoản thanh toán (payment) có amount từ 5 đến 10, sắp xếp giảm dần
theo amount.

select p.payment_id , p.amount 
from payment p 
where p.amount between 5 and 10
order by p.amount desc;

8 Tìm các phim có release_year = 2006 và replacement_cost > 25. 

select f.title , f.release_year , f.replacement_cost 
from film f 
where f.release_year = 2006 and f.replacement_cost > 25;
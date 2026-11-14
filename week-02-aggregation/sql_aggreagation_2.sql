BUỔI 3 · HAVING — KHÁC BIỆT GIỮA WHERE VÀ HAVING
3.1 Tìm các rating có từ 200 phim trở lên.

select f.rating , count(*) as total_film
from film f 
group by f.rating 
having count(*) >= 200;


3.2 Tìm các khách hàng đã thuê từ 40 lượt trở lên.

select r.customer_id , count(*) as total_rental
from rental r 
group by r.customer_id 
having count(*) >= 40;

3.3 Tìm các khách hàng có tổng chi tiêu trên 150.

select p.customer_id , sum(p.amount ) as total_amount
from payment p 
group by p.customer_id 
having sum(p.amount ) > 150;

3.4 Chỉ xét các phim có length > 100 (WHERE), sau đó tìm rating có
length trung bình > 120 (HAVING). Giải thích bằng comment vì sao
điều kiện length > 100 phải để ở WHERE chứ không phải HAVING.

select f.rating , avg(f.length ) as avg_length
from film f 
where length > 100
group by f.rating 
having avg(f.length) > 120;

-- length > 100 phải đặt ở WHERE vì đây là điều kiện lọc trên TỪNG DÒNG,
-- cần áp dụng TRƯỚC khi gom nhóm (WHERE chạy trước GROUP BY).
-- HAVING chạy SAU GROUP BY, chỉ lọc được trên kết quả của nhóm (hàm tổng hợp),
-- nên đặt length > 100 ở HAVING sẽ báo lỗi (length không nằm trong GROUP BY)
-- hoặc làm thay đổi ý nghĩa của truy vấn.



3.5 Chỉ xét các giao dịch thanh toán trong tháng 2/2007 (WHERE),
tìm khách hàng có tổng chi tiêu tháng đó > 20 (HAVING).

select p.customer_id , sum(p.amount )
from payment p 
where p.payment_date >= '2007-02-01'
  and p.payment_date <  '2007-03-01'
group by p.customer_id 
having sum(p.amount ) > 20;

3.6 Tìm các ngày có doanh thu vượt 2000 (GROUP BY ngày + HAVING).

select date(p.payment_date) , sum(p.amount )
from payment p 
group by date(p.payment_date)
having sum(p.amount) > 2000; 


3.7 Viết cùng một yêu cầu theo 2 cách và so sánh kết quả:
"các rating có rental_rate trung bình > 2.95"
Cách A: HAVING AVG(rental_rate) > 2.95
Cách B: subquery trong FROM rồi WHERE (không bắt buộc, chỉ để thử).

select f.rating , avg(f.rental_rate ) 
from film f 
group by f.rating 
having avg(f.rental_rate ) > 2.95;

select rating , avg_rental_rate 
from (
	select f.rating , avg(f.rental_rate ) as avg_rental_rate
	from film f 
	group by f.rating 
) as t
where avg_rental_rate > 2.95;

3.8 Câu hỏi lý thuyết (trả lời bằng comment):
a) Có thể dùng hàm tổng hợp trong WHERE không? Vì sao?
b) Có thể dùng HAVING mà không có GROUP BY không? Khi nào?

-- a) KHÔNG. Hàm tổng hợp (COUNT, SUM, AVG...) không dùng được trong WHERE.
--    Vì WHERE chạy TRƯỚC GROUP BY, lúc đó các nhóm chưa được tạo ra
--    nên chưa có gì để tính tổng hợp. WHERE chỉ lọc từng dòng riêng lẻ.
--    Muốn lọc theo kết quả tổng hợp thì dùng HAVING (chạy sau GROUP BY).
--    Ví dụ sai:  WHERE COUNT(*) > 5      -> báo lỗi
--    Ví dụ đúng: HAVING COUNT(*) > 5

-- b) CÓ. HAVING dùng được khi không có GROUP BY.
--    Lúc đó cả bảng được coi là MỘT nhóm duy nhất, và HAVING quyết định
--    có trả về dòng kết quả đó hay không.
--    Ví dụ:
--      SELECT COUNT(*) AS total_film
--      FROM film
--      HAVING COUNT(*) > 500;
--    -> trả về 1 dòng nếu bảng có hơn 500 phim, ngược lại trả về 0 dòng.
--    Trường hợp này ít gặp, thường chỉ dùng để kiểm tra điều kiện trên toàn bảng.
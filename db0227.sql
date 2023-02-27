alter table orders drop primary key;

show index from orders;

alter table orders add primary key(orderid);

show index from orders;

select custid as '고객번호' , round(avg(saleprice),-2) as '평균금액' from orders
group by custid;

select bookid, replace(bookname, '야구', '농구') as bookname, publisher, price from book;

select bookname as '제목', char_length(bookname) as '문자수', length(bookname) as '바이트수' from book
where publisher='굿스포츠';

select substr(name, 1, 1) as '성', count(*) as '인원'
from customer
group by substr(name, 1, 1);

select orderid as '주문번호', orderdate as '주문일', adddate(orderdate, interval 10 day) as '확정'
from orders;

select orderid as '주문번호', str_to_date(orderdate, '%Y-%m-%d') as '주문일', custid as '고객번호', bookid as '도서번호'
from orders
where orderdate=DATE_FORMAT('20140707', '%Y%m%d');

SELECT SYSDATE(), DATE_FORMAT(SYSDATE(), '%Y/%m/%d %M %h:%s') 'SYSDATE_1';

select name as '이름', ifnull(phone, '연락처없음') as '전화번호'
from customer;

set @seq:=0;
select (@seq:=@seq+1) as '순번', custid, name, phone
from customer
where @seq<2;

select (select name from customer cs where cs.custid = od.custid) name, sum(saleprice) total
from orders od
group by od.custid;

select name, sum(saleprice) total
from customer cs, orders od
where cs.custid = od.custid
group by od.custid;

select cs.name, SUM(od.saleprice) ‘total’ 
FROM (SELECT custid, name FROM Customer WHERE custid <= 2) cs, Orders od 
WHERE cs.custid=od.custid 
GROUP BY cs.name;

select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice) from orders);

SELECT orderid, custid, saleprice 
FROM Orders od 
WHERE saleprice > (SELECT AVG(saleprice) FROM Orders so WHERE od.custid=so.custid);

select sum(saleprice) total
from orders
where custid in (select custid from customer where address like '%대한민국%');

select orderid, saleprice
from orders
where saleprice > all(select saleprice from orders where custid=3);

select sum(saleprice) total
from orders od
where exists (select * from customer cs where address like '%대한민국%' and cs.custid=od.custid);

SELECT * FROM Book WHERE bookname LIKE '%축구%';

CREATE VIEW vw_Book AS SELECT * FROM Book WHERE bookname LIKE '%축구%';

CREATE VIEW vw_Customer AS SELECT * FROM Customer WHERE address LIKE '%대한민국%';

CREATE VIEW  vw_Orders (orderid, custid, name, bookid, bookname, saleprice, orderdate) 
AS SELECT od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate 
FROM Orders od, Customer cs, Book bk WHERE od.custid =cs.custid AND od.bookid =bk.bookid;

SELECT orderid, bookname, saleprice FROM vw_Orders WHERE name='김연아';

CREATE OR REPLACE VIEW vw_Customer (custid, name, address) 
as SELECT custid, name, address FROM Customer WHERE address LIKE '%영국%';

SELECT * FROM vw_Customer;
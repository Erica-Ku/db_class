select bookname, publisher
from book
where bookname like '%축구%';

select *
from book
where bookname like '_구%';

select *
from book
where bookname like '%축구%' and price>=20000;

select *
from book
where publisher='굿스포츠' or publisher='대한미디어';

select *
from book
order by bookname;

select *
from book
order by price, bookname;

select *
from book
order by price desc, publisher;

select sum(saleprice) as '주문금액'
from orders;

select sum(saleprice) as '총매출'
from orders
where custid=2;

select sum(saleprice) as 'total', avg(saleprice) as 'average', 
min(saleprice) as 'minimum', max(saleprice) as 'maximum'
from orders;

select count(*)
from orders;

select custid, count(*) as '도서수량', sum(saleprice) as '총액'
from orders
group by custid with rollup;

select custid, count(*)
from orders
where saleprice>=8000
group by custid
having count(*)>=2;

select *
from customer, orders
where customer.custid = orders.custid;

select customer.name, book.bookname
from customer, book, orders
where customer.custid=orders.custid
and orders.bookid = book.bookid;

select customer.name, saleprice
from customer left outer join orders
on customer.custid = orders.custid;

select customer.name
from customer left outer join orders
on customer.custid = orders.custid
where  saleprice is null;

select bookname
from book
where price=(select max(price) from book);

select distinct customer.name
from customer left outer join orders
on customer.custid=orders.custid
where orderid is not null;

select name from customer
where custid in (select custid from orders where bookid in
(select bookid from book where publisher='대한미디어'));

select customer.name 
from customer, orders, book
where customer.custid=orders.custid and book.bookid=orders.bookid
and publisher = '대한미디어';

select name from customer
where address like '대한민국%'
union
select name from customer
where custid in (select custid from orders);

select name from customer
where address like '대한민국%' and
name not in (select name  from customer where custid in
(select custid from orders));

select name from customer
where address like '대한민국%' and
name in (select name  from customer where custid in
(select custid from orders));
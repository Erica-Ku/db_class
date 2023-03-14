-- 1. InsertBook() 프로시저를 수정하여 고객을 새로 등록하는 InsertCustomer() 프로시저를 작성하시오.
delimiter // 
CREATE PROCEDURE InsertCustomer(  
IN myCustId INTEGER,   
IN myName VARCHAR(40),   
IN myAddress VARCHAR(50),   
IN myPhone varchar(20)) 
BEGIN  
INSERT INTO customer(custid, name, address, phone)    
VALUES(myCustId, myName, myAddress, myPhone); 
END; 
// 
delimiter ;

-- 2. BookInsertOrUpdate() 프로시저를 수정하여 삽입 작업을 수행하는 프로시저를 작성하시오. 
-- 삽입하려는 도서와 동일한 도서가 있으면 삽입하려는 도서의 가격이 높을 때만 새로운 값으로 변경한다.
drop procedure if exists BookInsertOrUpdate;
delimiter // 
CREATE PROCEDURE BookInsertOrUpdate(  
myBookID INTEGER,  
myBookName VARCHAR(40),   
myPublisher VARCHAR(40), 
myPrice INT) 
BEGIN  
DECLARE mycount INTEGER;  
SELECT count(*) INTO mycount FROM Book     
WHERE bookname LIKE myBookName;   
IF mycount!=0 THEN    
SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정 문 */    
UPDATE Book SET price = myPrice      
WHERE bookname LIKE myBookName and price < myPrice;  
ELSE    
INSERT INTO Book(bookid, bookname, publisher, price)      
VALUES(myBookID, myBookName, myPublisher, myPrice);  
END IF; 
END; 
// 
delimiter ;

-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분 
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 25000);
SELECT * FROM Book;
-- 15번 투플 삽입 결과 확인 
-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분 
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book;
-- 15번 투플 가격 변경 확인

-- 3. 출판사가 '이상미디어'인 도서의 이름과 가격을 보여주는 프로시저를 작성하시오.
delimiter $$
create procedure cursor_pro3()
begin
	declare myname varchar(40);
    declare myprice int;
    declare endofrow boolean default false;
    declare bookcursor cursor for select bookname, price from book where publisher="이상미디어";
    declare continue handler for not found set endofrow=true;
    open bookcursor;
    cursor_loop: Loop
		fetch bookcursor into myname, myprice;
        if endofrow then leave cursor_loop;
        end if;
        select myname, myprice;
	end loop cursor_loop;
    close bookcursor;
end $$
delimiter ;

call cursor_pro3();

-- 4. 출판사별로 출판사 이름과 도서의 판매 총액을 보이시오(판매 총액은 Orders 테이블에 있다).
DELIMITER $$
CREATE PROCEDURE publisher_per1()
BEGIN
    SELECT book.publisher, SUM(orders.saleprice) AS total_sales
    FROM book
    JOIN orders ON book.bookid = orders.bookid
    GROUP BY book.publisher;
END $$
DELIMITER ;

call publisher_per1();

-- 5. 출판사별로 도서의 평균가보다 비싼 도서의 이름을 보이시오
-- (예를 들어 A 출판사 도서의 평균가가 20,000원이 라면 A 출판사 도서 중 20,000원 이상인 도서를 보이면 된다).
delimiter $$
create procedure publisher_per2()
begin
	select b1.bookname from book b1
    where (select avg(b2.price) from book b2 where b2.publisher = b1.publisher) < b1.price;
end $$
delimiter ;

call publisher_per2();

-- 6. 고객별로 도서를 몇 권 구입했는지와 총 구매액을 보이시오.
delimiter $$
create procedure customer_per()
begin
	select custid, count(*) '구매권수', sum(saleprice) '총액' from orders
    group by custid;
end $$
delimiter ;

call customer_per();

-- 7. 주문이 있는 고객의 이름과 주문 총액을 출력하고, 주문이 없는 고객은 이름만 출력하는 프로시저를 작성하시오.
delimiter $$
create procedure customer_order()
begin
	declare done boolean default false;
    declare v_sum int;
    declare v_id int;
    declare v_name varchar(20);
	declare cursor1 cursor for select custid, name from customer;
    declare continue handler for not found set done = true;
    open cursor1;
		my_loop: Loop
        fetch cursor1 into v_id, v_name;
			select sum(saleprice) into v_sum from orders where custid=v_id;
            if done then
				leave my_loop;
			end if;
            select v_name, v_sum;
		end Loop my_loop;
	close cursor1;
end $$
delimiter ;

call customer_order();

-- 8. 고객의 주문 총액을 계산하여 20,000원 이상이면 '우수', 20,000원 미만이면 '보통'을 반환하는 함수 Grade()를 작성하시오.
-- Grade()를 호출하여 고객의 이름과 등급을 보이는 SQL 문도 작성하시오.
delimiter // 
CREATE FUNCTION Grade( 
sumsaleprice INTEGER) RETURNS varchar(10) 
BEGIN 
DECLARE myGrade varchar(10);
IF sumsaleprice >= 20000 THEN SET myGrade = '우수'; 
ELSE SET myGrade = '보통'; 
END IF; 
RETURN myGrade; 
END; // 
delimiter ;

-- SET GLOBAL log_bin_trust_function_creators = 1;

select name, Grade(sum(saleprice)) '등급' from customer, orders 
where customer.custid = orders.custid group by name;

-- 9. 고객의 주소를 이용하여 국내에 거주하면 '국내거주', 해외에 거주하면 '국외거주'를 반환하는 함수 Domestic() 을 작성하시오. 
-- Domestic()을 호출하여 고객의 이름과 국내/국외 거주 여부를 출력하는 SQL 문도 작성하시오.
delimiter // 
CREATE FUNCTION Domestic( 
address varchar(50)) RETURNS varchar(10)
BEGIN 
DECLARE myDomestic varchar(10);
IF address like "대한민국%" THEN SET myDomestic = '국내거주';
ELSE SET myDomestic = '국외거주';
END IF; 
RETURN myDomestic; 
END; // 
delimiter ;

select name, Domestic(address) '국내/국외' from customer;

-- 10. (9)번에서 작성한 Domestic()을 호출하여 국내거주 고객의 판매 총액과 국외거주 고객의 판매총액을 출력하는 SQL 문을 작성하시오.
select Domestic(address) '국내/국외', sum(saleprice) from customer, orders
where customer.custid = orders.custid
group by Domestic(address)
order by Domestic(address);
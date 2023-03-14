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
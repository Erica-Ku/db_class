delimiter // 
CREATE PROCEDURE InsertBook( 
IN myBookID INTEGER, 
IN myBookName VARCHAR(40), 
IN myPublisher VARCHAR(40), 
IN myPrice INTEGER) 
BEGIN 
INSERT INTO Book(bookid, bookname, publisher, price) 
VALUES(myBookID, myBookName, myPublisher, myPrice); 
END; 
// 
delimiter ;

CALL InsertBook(13, '스포츠과학', '마당과학서적', 25000);
CALL InsertBook(14, '야구과학', '마당과학서적', 5000);
SELECT * FROM Book;

delimiter // 
CREATE PROCEDURE BookInsertOrUpdate( 
myBookID INTEGER, 
myBookName VARCHAR(40), 
myPublisher VARCHAR(40), 
myPrice INT) 
BEGIN DECLARE mycount INTEGER; 
SELECT count(*) INTO mycount FROM Book WHERE bookname LIKE myBookName; 
IF mycount!=0 THEN 
SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정 문 */ 
UPDATE Book SET price = myPrice 
	WHERE bookname LIKE myBookName; 
ELSE 
	INSERT INTO Book(bookid, bookname, publisher, price) 
     VALUES(myBookID, myBookName, myPublisher, myPrice); 
END IF; 
END; 
// 
delimiter ;

CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 25000); 
SELECT * FROM Book; -- 15번 투플 삽입 결과 확인

CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book; -- 15번 투플 가격 변경 확인

delimiter // 
CREATE PROCEDURE Interest() 
BEGIN 
DECLARE myInterest INTEGER DEFAULT 0.0; 
DECLARE Price INTEGER; 
DECLARE endOfRow BOOLEAN DEFAULT FALSE; 
DECLARE InterestCursor CURSOR FOR 
	SELECT saleprice FROM Orders; 
DECLARE CONTINUE handler 
	FOR NOT FOUND SET endOfRow=TRUE; 
OPEN InterestCursor; 
cursor_loop: LOOP 
	FETCH InterestCursor INTO Price; 
    IF endOfRow THEN LEAVE cursor_loop; 
    END IF; 
    IF Price >= 30000 THEN 
		SET myInterest = myInterest + Price * 0.1; 
	ELSE 
		SET myInterest = myInterest + Price * 0.05; 
	END IF; 
    END LOOP cursor_loop; 
    CLOSE InterestCursor; 
    SELECT CONCAT(' 전체 이익 금액 = ', myInterest); 
END; 
// 
delimiter ;

/* Interest 프로시저를 실행하여 판매된 도서에 대한 이익금을 계산 */ 
CALL Interest();

SET global log_bin_trust_function_creators=ON; /* 실습을 위해 root 계정에서 실행
/* madang 계정에서 실습을 위한 Book_log 테이블 생성해준다. */ 
CREATE TABLE Book_log( 
bookid_l INTEGER, 
bookname_l VARCHAR(40), 
publisher_l VARCHAR(40), 
price_l INTEGER);
delimiter // 
CREATE TRIGGER AfterInsertBook 
AFTER INSERT ON Book FOR EACH ROW 
BEGIN 
DECLARE average INTEGER; 
INSERT INTO Book_log 
VALUES(new.bookid, new.bookname, new.publisher, new.price); -- new = update, insert / old = update, delete 주로 사용
END; 
// 
delimiter ;

/* 삽입한 내용을 기록하는 트리거 확인 */ 
INSERT INTO Book VALUES(16, '스포츠 과학 1', '이상미디어', 25000);
SELECT * FROM Book WHERE BOOKID=16;
SELECT * FROM Book_log WHERE BOOKID_L='16' ; -- 결과 확인
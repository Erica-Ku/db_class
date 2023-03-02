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
CREATE PROCEDURE 새학과( 
IN 학과번호 char(2), 
IN 학과명 char(20), 
IN 전화번호 char(20))
BEGIN 
INSERT INTO 학과(학과번호, 학과명, 전화번호) 
VALUES(학과번호, 학과명, 전화번호); 
END; 
// 
delimiter ;

CALL 새학과('08', '컴퓨터보안학과','022-200-7000');
select * from 학과 where 학과번호=08;

delimiter // 
CREATE PROCEDURE 통계(
OUT a INTEGER,
OUT b INTEGER,
OUT c INTEGER) 
BEGIN 
SELECT sum(distinct 학번) INTO a 
FROM 수강신청;
select 
END; 
// 
delimiter ;
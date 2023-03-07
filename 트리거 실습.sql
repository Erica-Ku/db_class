-- 상품 테이블 작성
CREATE TABLE 상품 (
   상품코드        VARCHAR(6) NOT NULL PRIMARY KEY,
   상품명           VARCHAR(30)  NOT NULL,
   제조사        VARCHAR(30)  NOT NULL,
   소비자가격  int, 
   재고수량     int DEFAULT 0
);

-- 입고 테이블 작성
CREATE TABLE 입고 (
   입고번호      int PRIMARY KEY
  ,상품코드      VARCHAR(6) NOT NULL
  ,입고일자     DATE
  ,입고수량      int
  ,입고단가      int
);

-- 판매 테이블 작성
CREATE TABLE 판매 (
   판매번호      int  PRIMARY KEY
  ,상품코드      VARCHAR(6) NOT NULL
  ,판매일자      DATE
  ,판매수량      int
  ,판매단가      int
);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
         ('EEEEEE', '프린터', '삼싱', 200000);
COMMIT;
SELECT * FROM 상품;

-- DROP TRIGGER IF EXISTS BeforeUpdate판매;

delimiter //
create trigger AfterInsert입고
after insert on 입고 for each row
begin
update 상품
set 재고수량 = 재고수량 + new.입고수량
where 상품코드 = new.상품코드;
end; //
delimiter ;

delimiter //
create trigger AfterUpdate입고
after update on 입고 for each row
begin
update 상품
set 재고수량 = 재고수량 + (new.입고수량 - old.입고수량)
where 상품코드 = new.상품코드;
end;
//
delimiter ;

delimiter //
create trigger AfterDelete입고
after delete on 입고 for each row
begin
update 상품
set 재고수량 = 재고수량 - old.입고수량
where 상품코드 = old.상품코드;
end;
//
delimiter ;

delimiter //
create trigger beforeInsert판매
before insert on 판매 for each row
begin
declare i int;
select 재고수량 into i from 상품 where 상품코드 = new.상품코드;
if i >= new.판매수량 then
	update 상품 
    set 재고수량 = i - new.판매수량
    where 상품코드 = new.상품코드;
else
    signal sqlstate '45000' set message_text = '재고수량 부족으로 판매 불가';
end if;
end; //
delimiter ;

delimiter //
create trigger beforeUpdate판매
before update on 판매 for each row
begin
declare i int;
select 재고수량 into i from 상품 where 상품코드 = new.상품코드;
if new.판매수량 <= (i + old.판매수량) then
	update 상품
    set 재고수량 = i - new.판매수량 + old.판매수량
    where 상품코드 = new.상품코드;
else
    signal sqlstate '45000' set message_text = '판매 수정 오류';
end if;
end; //
delimiter ;

INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (1, 'AAAAAA', '2004-10-10', 5,   50000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (2, 'BBBBBB', '2004-10-10', 15, 700000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (3, 'AAAAAA', '2004-10-11', 15, 52000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (4, 'CCCCCC', '2004-10-14', 15,  250000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (5, 'BBBBBB', '2004-10-16', 25, 700000);

INSERT INTO 판매 (판매번호, 상품코드, 판매일자, 판매수량, 판매단가) VALUES (1, 'AAAAAA', '2004-11-10', 5, 1000000);
INSERT INTO 판매 (판매번호, 상품코드, 판매일자, 판매수량, 판매단가) VALUES (2, 'BBBBBB', '2004-11-22', 3, 1800000);

update 입고 set 입고수량 = 10 where 입고번호 = 5;
delete from 입고 where 입고번호 = 4;

update 판매 set 판매수량=200 where 판매번호=1;
update 판매 set 판매수량=10 where 판매번호=1;
update 판매 set 판매수량=10 where 판매번호=2;
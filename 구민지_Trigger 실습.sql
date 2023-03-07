-- 판매 테이블에 자료가 추가되면 상품 테이블에 상품의 재고수량이 변경되는 트리거
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

-- 판매 테이블에 자료가 변경되면 상품 테이블에 상품의 재고수량이 변경되는 트리거
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
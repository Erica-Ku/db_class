delimiter // 
CREATE PROCEDURE 새학과( 
IN my학과번호 char(2), 
IN my학과명 char(20), 
IN my전화번호 char(20))
BEGIN 
INSERT INTO 학과(학과번호, 학과명, 전화번호) 
VALUES(my학과번호, my학과명, my전화번호); 
END; 
// 
delimiter ;

CALL 새학과('08','컴퓨터보안학과','022-200-7000');
call 새학과('07','국어교육과','022-200-7001');
call 학과_입력_수정('08','빅데이터보안학과','022-111-1111');
call 학과_입력_수정('06','사물인터넷학과','022-222-2222');
select * from 학과;

delimiter // 
CREATE PROCEDURE 통계( 
out a integer, 
out b integer, 
out c integer)
BEGIN 
select count(학번) into a from 수강신청;
select count(distinct 담당교수) into b from 과목;
select count(distinct 과목번호) into c from 수강신청내역;
END;
// 
delimiter ;

call 통계(@a, @b, @c);
select @a AS 학생수, @b AS 교수수, @c AS 과목수;

delimiter // 
CREATE PROCEDURE 과목수강자수( 
my과목번호 char(6), 
out Count integer
)
BEGIN
select count(*) into Count from 수강신청내역 where 과목번호 = my과목번호;
END;
// 
delimiter ;

call 과목수강자수('K20002', @Count);
select @Count;

delimiter // 
CREATE PROCEDURE 새수강신청( 
my학번 char(7), 
out 수강신청_번호 integer
)
BEGIN
select max(수강신청번호) into 수강신청_번호 from 수강신청;
set 수강신청_번호 = 수강신청_번호 + 1;
insert into 수강신청(수강신청번호, 학번, 날짜, 연도, 학기)
values (수강신청_번호, my학번, curdate(), '2023', '1');
END;
// 
delimiter ;

call 새수강신청('1804003', @수강신청_번호); -- 수강신청 테이블은 자식 테이블이기 때문에 부모에 없는 데이터를 넣을 수 없음(참조 무결성)
select @수강신청_번호;
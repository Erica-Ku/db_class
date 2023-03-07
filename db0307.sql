-- 트랜잭션
commit;
rollback;

select @@autocommit;

set autocommit = 0;
set autocommit = 1;

create table book1 (select * from book);
create table book2 (select * from book);

delete from book2;
commit;
rollback;

start transaction;
delete from book1;
delete from book2;
rollback;

start transaction;
savepoint A;
delete from book1;
savepoint B;
delete from book2;
rollback to savepoint B;
commit;

create table account(
accNum char(10) primary key,
amount int not null default 0);

insert into account values('A', 45000);
insert into account values('B', 100000);

start transaction;
update account set amount = amount-40000 where accNum = 'A';
update account set amount = amount+40000 where accNum = 'B';
rollback;

-- DROP TRIGGER IF EXISTS not인출;

delimiter //
create trigger not인출
before update on account for each row
begin
declare i int;
select amount into i from account where accNum = new.accNum;
if i < 40000 then
    signal sqlstate '45000' set message_text = '잔액 부족';
end if;
end; //
delimiter ;

delimiter //
create procedure `account_transaction`(
in sender char(15),
in recip char(15),
in _amount int)
begin
	declare exit handler for sqlexception rollback;
	start transaction;
	update account set amount = amount-_amount where accNum = sender;
	update account set amount = amount+_amount where accNum = recip;
	commit;
end; //
delimiter ;
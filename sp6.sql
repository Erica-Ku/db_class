-- 6. 고객별로 도서를 몇 권 구입했는지와 총 구매액을 보이시오.
delimiter $$
create procedure customer_per()
begin
	select custid, count(*) '구매권수', sum(saleprice) '총액' from orders
    group by custid;
end $$
delimiter ;

call customer_per();
show index from dept_emp;

show table status like 'dept_emp';

alter table dept_emp drop foreign key dept_emp_ibfk_1;
alter table dept_emp drop foreign key dept_emp_ibfk_2;
drop index dept_no on dept_emp;

analyze table dept_emp;
show index from dept_emp;

alter table dept_emp drop primary key;

select * from dept_emp order by emp_no asc limit 1;
select * from dept_emp order by emp_no desc limit 1;

select count(*) from dept_emp;
explain select * from dept_emp where emp_no=10001;
explain select * from dept_emp where emp_no=499999;

alter table dept_emp add primary key (emp_no, dept_no);
explain select * from dept_emp where emp_no=10001;
explain select * from dept_emp where emp_no=499999;

select count(*) from dept_emp where dept_no = 'd006';
explain select count(*) from dept_emp where dept_no = 'd006';

create index dept_emp on dept_emp(dept_no);
explain select count(*) from dept_emp where dept_no = 'd006';

select * from dept_emp where dept_no='d006' and from_date='1996-11-24';
explain select * from dept_emp where dept_no='d006' and from_date='1996-11-24';

create index from_date on dept_emp(from_date);
select * from dept_emp where dept_no='d006' and from_date='1996-11-24';
explain select * from dept_emp where dept_no='d006' and from_date='1996-11-24';

alter table dept_emp drop primary key;
alter table dept_emp drop index dept_emp;
alter table dept_emp drop index from_date;
analyze table dept_emp;


alter table dept_manager drop foreign key dept_manager_ibfk_1;
alter table titles drop foreign key titles_ibfk_1;
alter table employees drop primary key;
analyze table employees, dept_emp;


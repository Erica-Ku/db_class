-- 실습1
insert into 공급자 values(11111, '푸름상회', 'ㅇㅇㅇ', '부산시 해운대구', '판매', '잡화', 1211122);
insert into 공급자 values(11112, 'ㅇㅇ가구점', 'ㅇㅇㅇ', '부산시 해운대구', '판매', '가구', 2335555);

insert into 상품 values(11111, '가방', 'ㅇㅇㅇ', 5, 10000, 50000);
insert into 상품 values(11111, '신발', 'ㅇㅇㅇ', 5, 5000, 30000);
insert into 상품 values(11112, '의자', 'ㅇㅇㅇ', 5, 50000, 100000);

insert into 견적서(견적서번호, 공급자_등록번호, 견적날짜, 견적접수지, 담당)
	values(1, 11111, '20230309', '부산', 'ㅇㅇㅇ');
insert into 견적서(견적서번호, 공급자_등록번호, 견적날짜, 견적접수지, 담당)
	values(2, 11111, '20230311', '부산', 'ㅇㅇㅇ');
insert into 견적서(견적서번호, 공급자_등록번호, 견적날짜, 견적접수지, 담당)
	values(3, 11112, '20230315', '부산', 'ㅇㅇㅇ');

-- 실습2
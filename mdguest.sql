-- 21.12.15
select * from madang.book;
select * from madang.customer;

select * from madang.orders;
-- ORA-01031: insufficient privileges
-- mdguest가 madang으로부터 부여받은 book table 의 select 권한을 mdguest2에 줄 때 권한 부족으로 에러 발생
grant select on madang.book to mdguest2;
-- mdguest가 madang으로부터 부여받은 customer table 의 select 권한을 mdguest2에 부여 가능
-- 가능한 이유 => madang이 mdgeust에게 customer table 의 select 권한을 부여할 때 with grant option 사용
grant select on madang.customer to mdguest2;
-- madang이 모든 사용자에게 orders 테이블의 select 사용 권한
select * from madang.orders;

-- madang이 book 테이블의 select 권한을 revoke(철회)하면 사용  에러 발생
select * from madang.book;

-- madang이 customer 테이블의 select 권한을 revoke(철회)하면 사용  에러 발생
select * from madang.customer;

-- mdguest2 사용자에 속하는 newtable이라는 이름의 테이블을 생성 (권한부족으로 불가 에러)
CREATE TABLE mdguest2.newtable(
    myname varchar2(40),
    myphone varchar2(20)
);
-- 선생님이 수업시간에 안되서 넘어감...
insert into mdguest2.newtable(myname, myphone)
    values ('홍길동', '000-000-0100');
  
-- 본인에 속한 table 생성은 당연히 가능
CREATE TABLE newtable(
    myname varchar2(40),
    myphone varchar2(20)
);

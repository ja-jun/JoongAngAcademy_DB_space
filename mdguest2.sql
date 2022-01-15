-- 21.12.15
-- mdguest로부터 madang의 customer select 사용 권한을 받음
select * from madang.customer;
-- madang이 모든 사용자에게 orders 테이블의 select 사용 권한
select * from madang.orders;

-- mdguest가 mdguest2에게 부여한 customer 테이블의 select 권한을 자동 revoke(철회)되어 사용  에러 발생
select * from madang.customer;

CREATE TABLE newtable(
    myname varchar2(40),
    myphone varchar2(20)
);

select * from newtable;
-- 21.12.10
-- 부속질의

select sum(salesprice)
from orders
where custid = (
      select custid
      from customer  
      where name = '박지성'
);

select * from orders;

-- 1) select에서 사용하는 부속질의 (scalar(뜻:값이 하나) 부속질의) 
-- group by 결과로 나온 각 행들에 대해서 select문에서 부속질의를 실행하여 이름을 가져옴
-- equi-joinㅇ로 name을 가져올 수도 있음
select custid, (select name
                from customer cs
                where cs.custid=od.custid), 
       sum(salesprice)
from orders od
group by custid;

select custid, sum(salesprice)
from orders od
group by custid;

-- 2) Inline view (from에서 부속질의를 사용하여 table처럼 보이이기 때문에 inline view라고 함)
select cs.name, sum(od.salesprice) "total"
from (select custid, name 
      from customer
      where custid <= 2) cs,
      orders od 
where cs.custid=od.custid
group by cs.name;

select custid, name
from customer
where custid <= 2;

-- 3) 중첩질의 (where조건문에서 부속질의 사용)
-- 질의 4-16 각 고객의 평균 주문금액보다 큰 금액의 주문내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
select * from orders;

select orderid, custid, salesprice
from orders od
where salesprice > (select avg(salesprice)
                    from orders so
                    where od.custid=so.custid);

 select * from customer;
 select * from orders;
 
-- 질의 4-16 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오
-- where A in ( A ) : A는 같아야 함 
select sum(salesprice) "total"
from orders
where custid in (select custid
                 from customer
                 where address like '%대한민국%');
                 
-- all 
-- 예제) : salesprice > all (속성값1, 속성값2, 속성값3, ....) 
--        => salesprice가 집합()안에 있는 모든 속성값보다 크면 true
--       (속성값 중에 최대값보다 크면 true)
-- some(any) : some, any는 똑같은 의미이고 in과 기능이 동일
-- 예제) : salesprice > any (속성값1, 속성값2, 속성값3, ....) 
--        => salesprice가 집합()안에 있는 최소 하나의 속성값보다 크면 true
--       (속성값 중에 최소값보다 크면 true)

-- 질의 4-18 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
select orderid, salesprice
from orders
where salesprice > all (select salesprice
                        from orders
                        where custid = '3');

select orderid, salesprice
from orders
where salesprice > any (select salesprice
                        from orders
                        where custid = '3');

select orderid, salesprice
from orders
where salesprice > (select min(salesprice)
                        from orders
                        where custid = '3');

select * from orders;

-- EXISTS, NOT EXISTS
-- 1) 사용문법 where exitS (subquery), where not exists (subquery)
-- 2) 해당 행이 존재하면 true
-- 3) 기능은 in, any(some)와 동일

-- 질의 4-19 exist 연산자로 대한민국에 거주하는 곡개에게 판매한 도서의 총 판매액을 구하시오.
select sum(salesprice) "total"
from orders od
where exists (select *
              from customer cs
              where address like '%대한민국%' and cs.custid=od.custid); 

-- 21.12.13 
-- rownum : oracle에서 table 생성 후 row를 insert할 때마다 내부적으로 관리하는 순차 번호
--          모든 table에서 존재
select * from orders;
select * from customer;

select rownum, custid, name, phone
from customer;

select rownum 순번, custid, name, phone
from customer
where rownum <=2;

-- book table에서 price가 가장 작은 2개의 책을 선택하고 싶음
select rownum, book.* 
from book;
-- 1) order by를 적용해서 오름차순으로 sorting했지만, price가 가장 작은 2개 책을 선택 불가능
select rownum, book.*
from book
order by price;

select *
from (select * from book order by price) b
where rownum <= 2;

-- from 다음에 select를 사용하여 새로운 inline view table을 생성하면 
-- rownum이 view table기준으로 새로 생성됨
select rownum, b.*
from (select * from book order by price) b;

-- 책값(price)이 가장 큰 1~3위 까지의 행을 선택하시오.
select *
from (select * from book order by price desc) b
where rownum <= 3;
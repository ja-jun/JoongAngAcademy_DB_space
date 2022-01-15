-- 21.12.06

-- Oracle :데이터베이스시스템 (DBMS : Data Base Management System:S/W)
-- SQL (Structured Query Language)
-- 1) 오라클을 배운다고 이야기 하면, Oracle에서 만든 SQL 명령어를 이해하여 활용할 줄 안다.
-- 2) DB를 사용할려면 SQL programming language 문법을 알아야 함
-- 3) Java와 달리 SQL 명령어 단위별로 프로그램 실행하며, 실행 결과를 즉시 알 수 있음
--    - 단, PL/SQL은 Java처럼 여러개의 명령어를 하나의 프로그램으로 합쳐서 전체 프로그램 실행 시킬 수 있음
-- 4) Oracle, MySQL 등 모든 DBMS의 SQL 명령어 전체의 많은 부분이 표준으로 되어 있음
--   - Oracle에서 배운 SQL명령어 문법과 MySQL 등 SQL 명령어 문법과 상당부분이 같음  
-- 5) SQL의 입력데이터 타입과 출력데이터 타입은 모두  table로 구성되어 있음

-- Oracle, MySQL : RDBMS (Relational Data base Management System)

-- 스키마(schema) : 
-- - 데이터베이스의 구조와 제약조건에 관해 전반적인 명세를 기술한 것
-- - 데이터베이스에서 사용하는 Table 이름 정의, Table마다 속성(attribute, 상세정보) 정보, table간의 관계정보 관리

-- 21.12.07
-- 오라클 SQL 기본개념
-- relationship(관계)
--  각 행의 원소들과의 관계를 의미
-- cardinality : 행의 갯수
-- attribute : 속성, 열(column)
-- degree : 차수 (속성의 갯수)
-- super key
-- 후보키(candidate key), 기본키(primary key), 대리키, 대체키, 외래키(foreign key)
-- NULL : 속성값이 정해지지 않은 상태
-- (Java에서 null은 참조객체의 주소값이 없다라는 의미)
-- Book table : 책입고날자
-- - 책정보 미리 등록, 나중에 

-- selection : 행(row)를 선택
-- projection : 열(column)을 선택

-- 회사에서 Database와 관련된 프로그래밍 작업
-- 1. SQL을 만드는 작업
--  . 고객으로 부터 요청사항을 받음 
--    (작년 1년 동안 지역별로, 상위고객 10개 회사에 대하여 총 판매금액, 해당 상품, 영업직원 정보)
--   . => SQL문을 만들어야 함
-- 2. Web back-end server 프로그램에서 java로 SQL을 구현하는 코딩 작업

-- SQL 구분
-- 1. DDL : Data Defination Language
-- 2. DML : Data Manipulation Language
-- 3. DCL : Data Control Language

-- SQL : sturctured query language (커리는 sql에서 사용하는 용어, 보통 select문을 말함)
-- 1) Customer table의 모든 행 정보 가져오기
select * from customer;
-- 2) Customer table에서 name이 김연아 인 row(행)을 가져오기(selection), where조건문에서 실행
select * from customer where name = '김연아';
-- 3) Customer table에서 name이 김연아 인 row(행)에서 전화번호 정보만 가져오기
select phone 
from customer 
where name = '김연아';

select bookname, price 
from book;

select price, bookname 
from book;

select bookid, bookname, publisher, price 
from book;

-- * 는 모든 것을 다 가져오라는 의미
select * from book; 

select publisher 
from book;

-- distinct 중복 제거 기능
select distinct publisher 
from book; 

select * from book 
where price < 20000;

select * 
from book 
where price >= 10000 and price <= 20000;

-- 오라클은 between 기능이 있다.(윗문장은 자바 스타일)
select * from book
where price between 10000 and 20000;

-- ('굿스포츠', '대한미디어', '삼성당'): 집합
-- where 조건문에서 행(row)이 선택되는 기준 => 행마다 where 조건문의 결과가 true이면 결과로 보여줌
select * 
from book 
where publisher in ('굿스포츠', '대한미디어', '삼성당');

select * 
from book 
where price=7000;

select * 
from book 
where publisher = '굿스포츠' or publisher = '대한미디어';

select * 
from book 
where publisher NOT IN ('굿스포츠', '대한미디어');

-- like 는 여러개의 (멀티) 행들을 가져온다.
select bookname, publisher 
from book 
where bookname like '축구의 역사';

select bookname, publisher 
from book 
where bookname = '축구의 역사';

select bookname, publisher 
from book 
where bookname like '%축구%';

select bookname, publisher 
from book 
where bookname like '축구%';

select bookname, publisher 
from book 
where bookname like '%야구%';

-- _의미 : 한글자인데 어떠한 글자가 와도 된다는 의미 첫번째 글자는 어떤 글자가 와도 된다. 두번째 글자는 '구'가 와야한다.
-- % : 0개 이상의 글자 (_%같이 쓸 필요 없다)
select * 
from book 
where bookname like '_구%';

select * 
from book
where bookname like '__의%';

select * 
from book 
where bookname like '%바_블%';

select * 
from book 
where bookname like '%축구%' and price >= 20000;

select * 
from book 
where publisher= '굿스포츠' or publisher = '대한미디어';

-- order by 속성이름1, 속성이름2,, : 속성 이름 기준으로 오름차순 정렬 
select * 
from book order by bookname;

select * 
from book order by publisher;

select * 
from book order by price;

-- 앞에 있는 price부터 오름차순, price가 같을 경우 publisher 순으로
-- DESC : DESCENDING ORDER(내림차순), ASC : ASCENDING ORDER(오름차순) 정렬
-- ASC로 할 경우에는 생략이 가능(정렬 기준은 ASC)
select * 
from book order by price, publisher;

select * 
from book order by price desc, publisher asc;

select * 
from book order by price desc, publisher;

select * from orders;

--21.12.08
-- 집계함수 sum : 전체 행의 값을 모두 합한 값 구하는 함수 (Oracle에서 제공하는 내장함수)
select sum(salesprice) 
from orders;

select sum(salesprice) as 총매출 
from orders;

select sum(distinct salesprice) as 총매출 
from orders;

-- DATE 타입인 orderdate 속성에 대해서는 집계함수 sum 사용 불가
select sum(orderdate) 
from orders;

-- sum 은 한줄로 나타난다. 나중에 설명함
select sum(salesprice) as 총매출 
from orders 
where custid=2;

-- AVG : Average, 평균값 구하는 집계함수
-- MAX : 최대값 구하는 집계함수
-- MIN : 최소값 구하는 집계함수
select sum(salesprice) as total, 
           avg(salesprice) as Average, 
           min(salesprice) as Minimum, 
           MAX(salesprice) as Maximum 
from orders;

-- count : 행의 갯수 구하기 함수
select count(*) 
from orders;

-- * 집계함수 -SUM, AVG, MAX, MIN, COUNT 
-- => 기본적으로 테이블의 모든 행에 대하여 연산을 수행하여 한 개의 행만 생성 
-- -SELECT 문에서 속성으로 집계함수를 사용할 때 일반 속성과 섞어 쓰면 안됨(에러발생)
-- 단, group by로 지정된 속성은 집계함수와 같이 사용할 수 있음

-- * GROUP BY + 속성이름 
-- - 속성이름으로 그룹핑 의미
-- - group by는 집계함수와 같이 많이 사용함
-- - having : group by 결과 행들에 대하여 where처럼 행들을 선택할 때 사용
-- . group by 키워드 없이 having 단독 사용 불가
-- having 안에서는 속성이름 뿐만 아니라, 집계함수도 사용 가능
-- group by에서 속성이름이 여러개 나올 경우의 의미
-- .첫번째 속성으로 그룹핑하고, 그룹핑 결과내에서 두번째 속성으로 다시 소그룹으로 그룹핑함.
select custid, count(*) as 도서수량, sum(salesprice) as 총액 
from orders group by custid;

select count(*) as 도서수량, sum(salesprice) as 총액 
from orders;

-- SQL 실행 에러원인 : custid는 4개 행이 필요하고, COUNT, SUM은 한개 행만 필요하여 오라클에서 4개 행으로 결과를 만들 수 없어 에러 발생 시킴
select custid, count(*) as 도서수량, sum(salesprice) as 총액 
from orders;

-- error 발생 : bookid의 행의 갯수와 나머지 결과값의 행의 갯수가 안맞음, (데이터 결과 의미 없음)
select bookid, custid, count(*) as 도서수량, sum(salesprice) as 총액 
from orders 
group by custid;

select custid, count(*) as 도서수량 
from orders 
where salesprice >= 8000 
group by custid;

select custid, count(*) as 도서수량 
from orders 
where salesprice >= 8000 
group by custid having count(*) >= 2;

select * 
from customer, orders 
where customer.custid = orders.custid;

select * 
from customer, orders;

select * 
from customer, orders 
where customer.custid = orders.custid 
order by customer.custid;

select name, salesprice 
from customer, orders 
where customer.custid = orders.custid;

select name, sum(salesprice) 
from customer, orders 
where customer.custid = orders.custid 
group by customer.name order by customer.name;

select name, sum(salesprice) 
from customer, orders 
where customer.custid = orders.custid 
group by name order by name;

select customer.custid, customer.name, sum(salesprice) 
from customer, orders 
where customer.custid = orders.custid 
group by customer.custid, customer.name 
order by customer.name;

select customer.name, book.bookname
from customer, orders, book
where customer.custid =orders.custid and orders.bookid =book.bookid;

select * from orders;

select *
from customer, orders, book;

select customer.name, book.bookname
from customer, orders, book
where customer.custid =orders.custid and orders.bookid=book.bookid and book.price =20000;

-- ANSI SQL 
-- -ANSI(American National Standard Institute):미국산업협회(KS)
-- Oracle, MySQL등 제품마다 SQL 명령어 문법이 조금씩 상이한데, 표준화한 것을 말함
-- 'ON' keyword는 where를 의미 
-- ANSI JOIN
-- SELECT customer.name, salesprice
-- FROM customer full outer join orders
-- ON customer.custid =orders.custid;
select customer.name, salesprice
from customer left outer join 
        orders on customer.custid =orders.custid;

-- JOIN
-- 세타조인 : {=, <>, <=, >=, <, >} 동등조인의 상위개념으로 다 사용가능 / 실무에서 안쓴다.
-- 동등조인 : {==} 두개를 합치는데 null값은 제외함, 일반적으로 조인아라고 하면 등등조인임.
-- 동등조인(equi-join)을 구할 때, cartesian product를 한 후에 구한 것임
-- 외부조인(OUTER JOIN) : 자연조인시 조인에 실패한 투플을 모두 보여주되 값이 없는 대응 속성에는 NULL값을 체워서 반환
-- 자연조인 : (NATURAL JOIN) 동등조인에서 조인에 참여한 속성이 두번 나오지 않도록 두번째 속성을 제거한 결과를 반환함

-- right outer join
select customer.name, salesprice
from customer right outer join 
        orders on customer.custid =orders.custid;

-- full outer join
select customer.name, salesprice
from customer full outer join 
        orders on customer.custid =orders.custid;

-- (Oracle)left outer join (위와 동일)
select customer.name, salesprice
from customer, orders
where customer.custid =orders.custid(+);

-- 부속질의 (sub query)
-- 정의 : select안에 select문을 사용하는 경우, 포함된 select문을 말함
-- 사용하는 곳 : select에서 속성 선택할 때도 사용가능, from 다음에 table을 위해 사용 가능하고
--             where 조건문에서도 사용 가능
select bookname 
from book
where price = (
    select max(price) from book
);

select bookname
from book
where price = 35000;
    
select * from book;

select name
from customer
where custid in (select custid from orders);
-- select custid from orders 실행 결과
-- => (1,1,2,3,4,1,4,3,2,3)
-- => (1,2,3,4)

select name
from customer
where custid in (1, 2, 3, 4);

select name
from customer
where custid in (
    select custid
    from orders
    where bookid in (select bookid
                     from book 
                     where publisher = '대한미디어')); 

select name
from customer
where custid in (
    select custid
    from orders
    where bookid in (3,4)); 

-- in(.. in(3,4)) => in(1) 의미
select name
from customer
where custid in (1);
                
select * from book;

select * from orders;

select * from customer;
-- join문
select name
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid and publisher='대한미디어';

-- b1, b2 : book의 별명(alias)
select b1.bookname
from book b1
where b1.price > (select avg(b2.price)
                  from book b2
                  where b2.publisher = b1.publisher);
                  
-- 질의 3-32 도서를 주문하지 않은 고객의 이름을 보이시오.
select name
from customer
minus
select name
from customer
where custid in (select custid 
                 from orders);

-- 질의 3-33 주문이 있는 고객의 이름과 주소를 보이시오.
select name, address
from customer cs
where exists (select * 
             from orders od
             where cs.custid = od.custid);

select name, address
from customer cs
where not exists (select * 
             from orders od
             where cs.custid = od.custid);

-- 21.12.10(금)
select * from book;
select * from customer;
select * from orders;

--1. 마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
--(1) 도서번호가 1인 도서의 이름
select bookname from book where bookid=1;
--(2) 가격이 20,000원 이상인 도서의 이름
select bookname from book where price >= 20000;
--(3) 박지성의 총 구매액
select sum(salesprice) 
from orders 
where custid = (select custid from customer where name = '박지성');
--(4) 박지성이 구매한 도서의 수
select count(*) 
from orders 
where custid = (select custid from customer where name = '박지성');
--(5) 박지성이 구매한 도서의 출판사 수
SELECT COUNT(DISTINCT publisher) 
	FROM Customer, Orders, Book 
	WHERE Customer.custid=Orders.custid AND Orders.bookid=Book.bookid
	 AND Customer.name LIKE '박지성';
--(6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select bookname, price, price-salesprice 
from orders, customer, book
where customer.custid=orders.custid and orders.bookid=book.bookid
        and customer.name like '박지성';
--(7) 박지성이 구매하지 않은 도서의 이름
select bookname
from book b1
where not exists 
                (select bookname 
                from customer, orders 
                where customer.custid=orders.custid and orders.bookid=b1.bookid 
                 and customer.name like '박지성');

--2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
--(1) 마당서점 도서의 총 개수
select count(distinct bookname) from book;
--(2) 마당서점에 도서를 출고하는 출판사의 총 개수
select count(distinct publisher) from book;
--(3) 모든 고객의 이름, 주소
select name, address from customer;
--(4) 2014년 7월 4일~7월 7일 사이에 주문받은 도서의 주문번호
select orderid 
from orders 
where orderdate between '2014/07/4' and '2014/07/07';
--(5) 2014년 7월 4일~7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
select orderid from orders 
where orderdate 
not between '2014/07/4' and '2014/07/07';
--(6) 성이 ‘김’ 씨인 고객의 이름과 주소
select name, address 
from customer 
where name like '김%';
--(7) 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 이름과 주소
select name, address 
from customer 
where name like '김%아';
--(8) 주문하지 않은 고객의 이름(부속질의 사용)
select name 
from customer
where name not in (select name
                   from orders, customer
                   where orders.custid=customer.custid);
--(9) 주문 금액의 총액과 주문의 평균 금액
select sum(salesprice), avg(salesprice)
from orders;
--(10) 고객의 이름과 고객별 구매액
select name, sum(salesprice) 
from customer, orders 
where customer.custid = orders.custid
group by name;
--(11) 고객의 이름과 고객이 구매한 도서 목록
select name, bookname 
from book, customer, orders 
where book.bookid = orders.bookid and customer.custid=orders.custid;
--(12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
select *
from book, orders
where book.bookid=orders.bookid
      and price - salesprice = 
                                (select max(price-salesprice)
                                from book, orders
                                where book.bookid=orders.bookid);
--(13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
select name, avg(salesprice)
from customer, orders
where customer.custid=orders.custid
group by name
having avg(salesprice) > (select avg(salesprice) from orders);
--3. 마당서점에서 다음의 심화된 질문에 대해 SQL 문을 작성하시오.
--(1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select name from customer, orders, book
where customer.custid=orders.custid
      and orders.bookid=book.bookid
      and name not like '박지성'
      and publisher in 
                       (select publisher from customer, orders, book
                        where customer.custid=orders.custid
                        and orders.bookid=book.bookid
                        and name like '박지성');
--(2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름 ??? 뒷부분 )ord
select name, pubcnt from 
                        (select name, count(distinct publisher) pubcnt
                        from customer, orders, book
                        where customer.custid=orders.custid
                        and orders.bookid=book.bookid
                        group by orders.custid, name) ord
                        where pubcnt >=2;
--(3) 전체 고객의 30% 이상이 구매한 도서 ??? b1의미? 0.3 뒤의 select문??
select bookname from book b1
where ((select count(book.bookid) from book, orders
        where book.bookid=orders.bookid 
        and book.bookid=b1.bookid) 
                                  >= 0.3 * (select count(*) from customer));
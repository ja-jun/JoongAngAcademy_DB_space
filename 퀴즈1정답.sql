--1.1
SELECT bookname FROM Book WHERE bookid=1;
--1.2
SELECT bookname FROM Book WHERE price >= 20000;
--1.3
SELECT SUM(salesprice) 
	FROM Customer, Orders 
	WHERE Customer.custid=Orders.custid 
		AND Customer.name LIKE '박지성';
--1.4
SELECT COUNT(*) FROM Customer, Orders 
	WHERE Customer.custid=Orders.custid 
	AND Customer.name LIKE '박지성';
--1.5
SELECT COUNT(DISTINCT publisher) 
	FROM Customer, Orders, Book 
	WHERE Customer.custid=Orders.custid AND Orders.bookid=Book.bookid
	 AND Customer.name LIKE '박지성';
--1.6
SELECT bookname, price, price-salesprice 
	FROM Customer, Orders, Book 
	WHERE Customer.custid=Orders.custid AND Orders.bookid=Book.bookid
	AND Customer.name LIKE '박지성';
--1.7
	SELECT bookname FROM Book b1
	WHERE NOT EXISTS 
	 (SELECT bookname FROM Customer, Orders
	 WHERE Customer.custid=Orders.custid AND Orders.bookid=b1.bookid
	 AND Customer.name LIKE '박지성');
--2.1
	SELECT count(*) FROM Book;
--2.2
SELECT COUNT(Distinct publisher)
	FROM Book;
--2.3
SELECT name, address
	FROM Customer;
--2.4
SELECT *
	FROM Orders
	WHERE orderdate BETWEEN '20140704' AND '20140707';
--2.5
SELECT *
	FROM Orders
	WHERE orderdate not BETWEEN '20140704' AND '20140707';
--2.6
SELECT name, address
	FROM Customer
	WHERE name LIKE '김%';
--2.7
SELECT name, address
	FROM Customer
	WHERE name LIKE '김%아';
--2.8
SELECT name FROM Customer
	WHERE name NOT IN 
		(SELECT name
		FROM Orders, Customer
		WHERE Orders.custid=Customer.custid);
--2.9
SELECT SUM(salesprice), AVG(salesprice)
	FROM Orders;

--2.10
SELECT name, SUM(salesprice)
	FROM Orders, Customer
	WHERE Orders.custid=Customer.custid
	GROUP BY name;
--2.11
SELECT name, bookname
	FROM Book, Orders, Customer
	WHERE Book.bookid=Orders.bookid 
	 AND Orders.custid=Customer.custid;
--2.12
SELECT *
	FROM Book, Orders
	WHERE Book.bookid=Orders.bookid
	 AND price-salesprice=
		(SELECT MAX(price-salesprice)
         FROM Book, Orders
         WHERE Book.bookid=Orders.bookid);
--2.13         
  SELECT name, AVG(salesprice) 
	FROM Customer, Orders
	WHERE Customer.custid=Orders.custid
	GROUP BY name 
	HAVING AVG(salesprice) > 
	 (SELECT AVG(salesprice) FROM Orders); 
--3.1
SELECT name FROM Customer, Orders, Book 
WHERE Customer.custid=Orders.custid
AND Orders.bookid=Book.bookid 
AND name NOT LIKE '박지성' 
AND publisher IN 
                (SELECT publisher FROM Customer, Orders, Book 
                 WHERE Customer.custid=Orders.custid
               	 AND Orders.bookid=Book.bookid
                 AND name LIKE '박지성');
--3.2
SELECT name, pubcnt FROM 
                       (SELECT name, COUNT(DISTINCT publisher) pubcnt
                        FROM Customer, Orders, Book 
                        WHERE Customer.custid=Orders.custid
                        AND Orders.bookid=Book.bookid 
                        group by orders.custid, name) ord
                        WHERE pubcnt >= 2;
--3.3
SELECT bookname FROM Book b1
WHERE ( (SELECT COUNT(Book.bookid) FROM Book, Orders 
    	 WHERE Book.bookid=Orders.bookid AND Book.bookid=b1.bookid)
    	 >= 0.3 * (SELECT COUNT(*) FROM Customer));

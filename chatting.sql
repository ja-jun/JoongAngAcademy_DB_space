
-- Employee table
Drop TABLE employee;

CREATE TABLE employee(
emplid number(6) PRIMARY KEY,   -- 사번
name VARCHAR2(60) NOT NULL,     -- 이름
password VARCHAR2(60) NOT NULL, -- 비밀번호
emailaddr VARCHAR2(60)NOT NULL, -- emial address
socialno VARCHAR2(20) NOT NULL,   -- 주민등록번호
dept VARCHAR2(60),              -- 부서명
adminyn CHAR(2)                 -- 관리자 여부 (Y,N)
);

INSERT INTO EMPLOYEE (EMPLID, NAME, PASSWORD, EMAILADDR, SOCIALNO, DEPT, ADMINYN) values(111111, '김나라', 'abcd', 'abc@chat.com', '950201-1002900', '영업', 'N');
INSERT INTO EMPLOYEE (EMPLID, NAME, PASSWORD, EMAILADDR, SOCIALNO, DEPT, ADMINYN) values(222222, '홍길동', 'abcd', 'cbb@chat.com', '940522-2032500', '관리', 'N');
INSERT INTO EMPLOYEE (EMPLID, NAME, PASSWORD, EMAILADDR, SOCIALNO, DEPT, ADMINYN) values(333333, '고길동', 'abcd', 'abb@chat.com', '970201-1032500', '인사', 'N');
INSERT INTO EMPLOYEE (EMPLID, NAME, PASSWORD, EMAILADDR, SOCIALNO, DEPT, ADMINYN) values(444444, '둘리', 'abcd', 'eee@chat.com', '890912-1456901', '재무', 'N');
INSERT INTO EMPLOYEE (EMPLID, NAME, PASSWORD, EMAILADDR, SOCIALNO, DEPT, ADMINYN) values(555555, '마이콜', 'abcd', 'qwe@chat.com', '970201-1431711', 'IT', 'Y');

commit;

select * from employee;

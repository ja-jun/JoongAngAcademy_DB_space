-- 21.12.14
-- WEB APPLICATION 개발
-- - DATEBASE : DML 명령어(SELECT, INSERT, UPDATE, DELETE)들을 자바 프로그램에서 사용
-- - CREATE TABLE(속성 테이터타입 CONSTRAINTS) 많이 사용

-- 1. NOT NULL
-- 2. UNIQUE
-- 3. PRIMARY KEY
-- 4. FOREIGN KEY
-- 5. CHECK

-- DATEBASE의 3대 무결성 제약조건
-- 1. DOMAIN(속성) 무결성 제약조건
--   - NOT NULL, UNIQUE, CHECK
-- 2. 개체 무결성 제약조건
--   - PRIMARY KEY
-- 3. 참조 무결성 제약조건
--   - FOREIGN KEY
SELECT * FROM DEPT01;
DROP TABLE DEPT01;

DESC DEPT;

CREATE TABLE DEPT01
AS
SELECT * FROM DEPT;

DESC DEPT01;

-- 1. PRIMARY KEY의 NOT NULL 제약조건 확인
INSERT INTO DEPT
VALUES(10, 'TEST', 'SEOUL'); -- 에러 발생 ORA-00001: unique constraint (SCOTT.SYS_C007024) violated

INSERT INTO DEPT
VALUES(NULL, 'TEST', 'SEOUL'); -- 에러 발생 ORA-01400: cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")

SELECT * FROM DEPT;

-- USER TABLE 정보보기
SELECT TABLE_NAME FROM USER_TABLES
ORDER BY TABLE_NAME DESC;

-- USER CONSTRAINTS (ALL_CONSTRAINTS, DBA_CONSTRAINTS VIEW TABLE도 존재함)
DESC USER_CONSTRAINTS;
-- P : PRIMARY KEY, R : FOREIGN KEY, C : CHECK와 NOT NULL을 의미, U : UNIQUE
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;

-- DEPTNO에 PRIMARY KEY가 지정되어 있지 않음
-- DEPT01에 INSERT, UPDATE등을 통해 중복된 행들이 추가할 가능성이 높아 DEPT01 테이블의 데이터 신뢰도가 낮아짐
DESC DEPT01;
INSERT INTO DEPT01
VALUES(10, 'TEST', 'SEOUL');

INSERT INTO DEPT01
VALUES(NULL, 'TEST', 'SEOUL');

SELECT * FROM DEPT01;
 
DROP TABLE EMP_HR;
DROP TABLE EMP_HR02;
DROP TABLE EMP_MGR;
DROP TABLE EMP_SAL;

DROP TABLE EMP01;
DROP TABLE EMP03;
DROP TABLE EMP04; 
DROP TABLE EMP05;

-- EMP01 : EMPNO, ENAME에 대하여 NOT NULL만 설정
create table emp01(
    empno NUMBER(4) NOT NULL, 
    ENAME VARCHAR2(10) NOT NULL, 
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2)
);

DESC EMP01;

-- ORA-01400: cannot insert NULL into ("SCOTT"."EMP01"."EMPNO")
-- EMPNO, EMANE이 NOT NULL로 선언되어 있어서 NULL로 INSERT하면 에러 발생
INSERT INTO EMP01
VALUES(NULL, NULL, 'SALESMAN', 10);

INSERT INTO EMP01
VALUES(NULL, 'SCOTT', 'SALESMAN', 10);

INSERT INTO EMP01
VALUES(7499, 'ALLEN', 'SALESMAN', 10);

SELECT * FROM EMP01;
-- EMPNO가 중복된 것을 새로 INSERT해도 됨(DEPTNO가 NOT NULL이지만 UNIQUE가 아니기 때문임)
INSERT INTO EMP01
VALUES(7499, 'SCOTT', 'MANAGER', 20);

SELECT * FROM EMP01;

-- UNIQUE 실습
DROP TABLE EMP03;
CREATE TABLE EMP03 ( 
    EMPNO NUMBER(4) UNIQUE, 
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2)
);

DESC EMP03;

-- SQL문으로 UNIQUE 확인(CONSTRAINIT_TYPE : U)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;
 
INSERT INTO EMP03
VALUES(7499, 'ALLEN', 'SALESMAN', 10);

-- ORA-00001: unique constraint (SCOTT.SYS_C007044) violated
-- EMPNO가 UNIQUE로 선언되어 있어서 중복값을 INSERT하면 에러 발생
INSERT INTO EMP03
VALUES (7499, 'SCOTT', 'MANAGER', 20);
-- UNIQUE로 선언된 경우는 NULL값도 새로운 값으로 인식하여 INSERT됨
INSERT INTO EMP03
VALUES(NULL, 'SCOTT', 'SALESMAN', 20);
-- UNIQUE로 선언된 경우에 NULL을 여러번 INSERT해도 중복체크하지 않음
-- NULL의 의미가 정해지지 않은 수 
INSERT INTO EMP03
VALUES(NULL, 'JOHNS', 'ANALYST', 30);

-- CONSTRAINT NAME 지정 방법
-- CONSTRAINT + CONSTAINT이름 (예 : CONSTRAINT EMP04_EMPNO_UK, CONSTRAINT EMP04_ENAME_NN은 이름(테이블명,칼럼명,)
DROP TABLE EMP04;

CREATE TABLE EMP04 (
    EMPNO NUMBER(4) CONSTRAINT EMP04_EMPNO_UK UNIQUE,
    ENAME VARCHAR2(10) CONSTRAINT EMP04_ENAME_NN NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2)
);

SELECT * FROM EMP04;
 
INSERT INTO EMP04
VALUES(7499, 'ALLEN', 'SALESMAN', 10);
 
INSERT INTO EMP04
VALUES (7499, 'SCOTT', 'MANAGER', 20);

INSERT INTO EMP04
VALUES (7455, NULL, 'MANAGER', 20);

select * from emp04;

-- PRIMARY KEY
DROP TABLE EMP05;
-- PRIMARY KEY = UNIQUE + NOT NULL
CREATE TABLE EMP05 (
    EMPNO NUMBER(4) CONSTRAINT EMP05_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10) CONSTRAINT EMP05_ENAME_NN NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2)
);
INSERT INTO EMP05
VALUES(7499, 'ALLEN', 'SALESMAN', 10);

INSERT INTO EMP05
VALUES (7566, 'SCOTT', 'MANAGER', 20);

-- UNIQUE ERROR (PRIMARY KEY)
INSERT INTO EMP05
VALUES (7499, 'SCOTT', 'MANAGER', 20);
-- NOT NULL ERROR (PRIMARY KEY)
INSERT INTO EMP05
VALUES (NULL, 'SCOTT', 'MANAGER', 20);

SELECT * FROM EMP05;
-- FOREIGN KEY 사용하기
SELECT * FROM DEPT;
SELECT * FROM EMP;
-- ORA-02291: integrity constraint (SCOTT.FK_DEPTNO) violated - parent key not found
-- FOEIGN KEY값 50은 DEPT 테이블의 DEPTNO에 없어서 FOREIGN KEY 에러 발생
INSERT INTO EMP(EMPNO, ENAME, DEPTNO)
VALUES(8000, 'TEST', 50);

DROP TABLE EMP06;
-- FOEIGN KEY 지정 방법 : REFERENCES DEPT(DEPTNO) (REFERENCES + TABLE 이름 + 기본키)
CREATE TABLE EMP06 (
    EMPNO NUMBER(4) CONSTRAINT EMP06_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10) CONSTRAINT EMP06_ENAME_NN NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EMP06_DEPTNO_FK REFERENCES DEPT(DEPTNO)
);
INSERT INTO EMP06
VALUES(7499, 'ALLEN', 'SALESMAN', 10);

-- ORA-02291: integrity constraint (SCOTT.EMP06_DEPTNO_FK) violated - parent key not found
-- FOREIGN KEY 에러 발생
INSERT INTO EMP06
VALUES (7566, 'SCOTT', 'MANAGER', 50);

SELECT * FROM EMP06;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;

-- CHECK 사용법
DROP TABLE EMP07;
CREATE TABLE EMP07(
    EMPNO NUMBER(4) CONSTRAINT EMP07_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10) CONSTRAINT EMP07_ENAME_NN NOT NULL,
    SAL NUMBER(7, 2) CONSTRAINT EMP07_SAL_CK CHECK(SAL BETWEEN 500 AND 5000),
    GENDER VARCHAR2(1) CONSTRAINT EMP07_GENDER_CK CHECK (GENDER IN('M', 'F'))
);

INSERT INTO EMP07
VALUES(7499, 'ALLEN', 3000, 'M');
-- ORA-02290: check constraint (SCOTT.EMP07_SAL_CK) violated
INSERT INTO EMP07
VALUES(7699, 'MARY', 6000, 'F');

INSERT INTO EMP07
VALUES(7699, 'MARY', 4500, 'F');
-- ORA-02290: check constraint (SCOTT.EMP07_GENDER_CK) violated
INSERT INTO EMP07
VALUES(7899, 'QUEEN', 3000, 'Q');

INSERT INTO EMP07
VALUES(7899, 'QUEEN', 3000, 'f');

INSERT INTO EMP07
VALUES(7899, 'QUEEN', 3000, 'F');

SELECT * FROM EMP07;

-- DEFAULT 사용하기
-- INSERT문을 사용하여 행을 생성할 때, DEFAULT로 선언된 속성에 대한 값을 명시적으로 주지 않으면 
-- DEFAULT로 설정된 값으로 생성됨
DROP TABLE DEPT01;
CREATE TABLE DEPT01(
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13) DEFAULT 'SEOUL'
);

INSERT INTO DEPT01 (DEPTNO, DNAME)
VALUES(10, 'ACCOUNTING');

SELECT * FROM DEPT01;

-- 테이블 레벨 방식으로 CONSRTAINT 조건 지정하기
DROP TABLE EMP02;
CREATE TABLE EMP02 (
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10) NOT NULL, 
    JOB VARCHAR2(9),
    DEPTNO NUMBER(4),
    -- TABLE LEVEL CONSTRAINT 지정
    PRIMARY KEY(EMPNO),
    UNIQUE(JOB),
    FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
);

DESC EMP02;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;

DROP TABLE EMP03;
-- NOT NULL, DEFAULT는 COLUMN(속성) LEVEL만 CONSTRAINT 지정 가능
-- TABLE LEVEL로 지정 가능한 CONSTRAINT : PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK
CREATE TABLE EMP03 (
    EMPNO NUMBER(4) CONSTRAINT EMP03_ENAME_NN NOT NULL,
    ENAME VARCHAR2(10), 
    JOB VARCHAR2(9),
    DEPTNO NUMBER(4),
    -- TABLE LEVEL CONSTRAINT 지정
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY(EMPNO),
    CONSTRAINT EMP03_JOB_UK UNIQUE(JOB),
    CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
);

-- 복합키를 기본키로 지정 (TABLE LEVEL로만 CONSTRAINT 지정 가능)
CREATE TABLE MEMBER01(
    NAME VARCHAR2(10),
    HPHONE VARCHAR2(16),
    ADRESS VARCHAR2(30),
    -- 복합키를 TABLE LEVEL로 CONSTRAINT 지정
    CONSTRAINT MEMBER01_COMBO_PK PRIMARY KEY(NAME, HPHONE)
);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;

SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME = 'MEMBER01';

-- TABLE 생성 후 CONSTRAINT 추가하기
DROP TABLE EMP01;
CREATE TABLE EMP01(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    DEPTNO NUMBER(4)
-- , CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY(EMPNO),
--  CONSTRAINT EMP01_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;

-- TABLE 생성후 CONSTRAINT 추가 SQL 문법 예
-- TABLE LEVEL로 CONSTRAINT가 추가가 됨
ALTER TABLE EMP01
ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY(EMPNO);
 
ALTER TABLE EMP01
ADD CONSTRAINT EMP01_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO);

-- TABLE 생성 후 COLUMN LEVEL에서 CONSTRAINT 추가(NOT NULL은 COLUMN 레벨만 변경 가능, TABLE LEVEL 변경 불가)
ALTER TABLE EMP01
MODIFY ENAME CONSTRAINT EMP01_ENAME_NN NOT NULL;

-- TABLE에 설정된 CONSTRAINT 제거하기
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME 
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP05';

-- PRIMARY KEY CONSTRAINT 삭제
ALTER TABLE EMP05
DROP CONSTRAINT EMP05_EMPNO_PK;

SELECT * FROM EMP05;

INSERT INTO EMP05
VALUES(7566, 'MARY', 'ANALYST', 20);
-- NOT NULL CONSTRAINT 삭제
ALTER TABLE EMP05
DROP CONSTRAINT EMP05_ENAME_NN;

INSERT INTO EMP05
VALUES(7566, NULL, 'CLERK', 30);
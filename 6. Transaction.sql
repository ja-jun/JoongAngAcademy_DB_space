-- 21.12.13
-- JAVA PROGRAMMING -SQL 사용(SELECT, INSERT, UPDATE, DELETE) 주로사용

-- TRANSACTION : 아주 중요한 개념
-- - TRANSACTION => 은행에서 나온 개념
-- - 전국에 지점, 해외에서 법인/지점
-- - S/W를 이용하여 비지니스에 거의 최초로 적용한 산업군
-- - 각 지점마다 매일 결산 
-- - (업무 시작전의 현금, 금융자산 보유 금액, 업무 종료후의 현금, 금융자산 보유금액)
-- - 장부상의 금액과 실제 현금 금액이 일치하는 가를 매일 체크
-- . A은행의 예금주 홍길동이 해외 B은행의 김길동에게 2000원 송금하고, 송금 수수료를 50원을 은행에 납부
--   1) 홍길동 : 2050원이 예금 통장에서 출금,
--   2) A은행과 해외 B은행이 송금수수료를 2:8로 나누어 가졌다면, A은행에 10원, 해외 B은행에 40원이 입금
--   3) 김길동 : 2000원이 예금통장에 입금
-- . 1 transaction : 1)~3)까지의 모든 입출금이 완료되었을 경우를 의미
-- . 1 transaction의 SW application상의 의미 : 각 은행의 시스템에 최종 값으로 정상적으로 처리 완료된 상태
-- . 1 transaction이 정상적으로 처리 완료되지 않으면, 원래의 최초 상태로 원복이 되어야 함

-- Transaction 과 관련된 SQL 명령어 : COMMIT, SAVEPOINT, ROLLBACK

-- ROLLBACK : DELETE, UPDATE, INSERT 등 테이블에서 수정된 행들을 수정되기 이전 상태로 원복(원래 상태로 복귀)
--            바로 직전의 COMMIT이후에 수정된 행들을 원복한다는 개념임
-- 사용목적 : 1개의 transaction안에 있는 여러 SQL문 중 1개라도 실행 중 에러가 발생하면,
--           이미 실행된 다른 SQL문들을 원래 초기상태로 정상 복귀하기 위해 사용하는 명령어
DESC DEPT01;

DROP TABLE DEPT01;

CREATE TABLE DEPT01
AS
SELECT * FROM DEPT;

SELECT * FROM DEPT01;

DELETE FROM DEPT01;

ROLLBACK;

DELETE FROM DEPT01 WHERE DEPTNO=20;

ROLLBACK;

-- COMMIT : INSERT, UPDATE, DELETE등으로 수정된 테이블 행들 데이터 값을 확정
--          COMMIT 명령어를 실행한 후에 ROLLBACK을 하더라도 최초 상태로 복귀하지 않음
-- 1) CREATE TABLE등 TABLE 생성 명령어를 사용하면 내부적으로 COMMIT명령어를 실행하여, 
--    이후 ROLLBACK을 하여도 원래 상태로 복귀 못함
--    - CREATE TABLE SQL 문법이 틀려 에러가 나더라도 CREATE TABLE을 수행하면 내부적으로 COMMIT명령어 실행
-- 2) 사용 목적 : 1 transaction내에 포함된 모든 sql문들이 정상적으로 완료되면 맨 마지막에 commit 실행해서
--               1 transaction에 포함된 sql문들의 실행결과가 나중에 rollback에 의해서 원상복귀 되지 못하도록 
--               최종 확정(승인)하는 명령어 
DROP TABLE DEPT02;

CREATE TABLE DEPT02
AS 
SELECT * FROM DEPT;

SELECT * FROM DEPT02;

DELETE FROM DEPT02 WHERE DEPTNO=20;

COMMIT;

ROLLBACK; -- COMMIT을 실행한 후에 ROLLBACK 명령어 실행해도 효과 없음

SELECT * FROM  DEPT02;

DELETE FROM DEPT02 WHERE DEPTNO=40;

CREATE TABLE DEPT03
AS
SELECT * FROM DEPT;

SELECT * FROM DEPT03;
DESC DEPT03;

ROLLBACK; -- CREATE TABLE안에 COMMIT명령어가 포함되어 실행이 되어 ROLLBACK을 해도 동작 않함

SELECT * FROM DEPT02;

DELETE FROM DEPT02 WHERE DEPTNO = 10;

CREATE TABLE DEPT04
AS
SELECT * FROM DEP;

ROLLBACK; -- create table 명령어가 잘못되어 에러가 발생되어 commit 명령어 실행하여 rollback 안됨

-- 2021.12.14
select * from dept03;

delete from dept03 where deptno=20;

-- delete from dept03;
-- TRUNCATE 명령어는 CREATE TABLE 명령어와 같은 DDL로 내부적으로 COMMIT 명령어를 무조건 실행함
truncate table dept03; 

ROLLBACK;

-- DELETE 명령어와 TRUNCATE 명령어의 차이점
-- 1) DELETE : DML의 명령어이고 ROLLBACK에 의해서 원상복귀 가능
-- 2) TRUNCATE : DDL의 명령어이고 내부적으로 COMMIT을 실행하여 ROLLBACK에 의해 원상 복귀 안됨
-- 3) TRUNCATE가 DELETE보다 수행 속도가 빨라 만약 TABLE의 전체 행을 삭제할 경우 TRUNCATE 사용 권장
--    DELETE가 속도가 느린 이유는 나중에 ROLLBACK을 대비해서 최초 데이터들을 별도로 SAVE하여 관리하기 때문

-- 3. SAVEPOINT : 중간단계 저장
DROP TABLE DEPT03;
DROP TABLE DEPT02;

SELECT * FROM DEPT01;

DELETE FROM DEPT01 WHERE DEPTNO=40;

COMMIT;
ROLLBACK;

DELETE FROM DEPT01 WHERE DEPTNO=30;

SAVEPOINT C1; -- C1전에 DELETE등 DDL명령어의 수행결과를 임시 저장(1차 COMMIT)

DELETE FROM DEPT01 WHERE DEPTNO=20;

SAVEPOINT C2;

DELETE FROM DEPT01 WHERE DEPTNO=10;

ROLLBACK TO C2; -- SAVEPOINT C2까지 원복(ROLLBACK)
ROLLBACK TO C1; -- SAVEPOINT C1까지 원복(ROLLBACK)
ROLLBACK;       -- COMMIT이후 최초단계까지 원복(ROLLBACK)

SELECT * FROM DEPT01;
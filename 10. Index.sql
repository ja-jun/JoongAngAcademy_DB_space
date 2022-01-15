-- 21.12.15
-- [INDEX]
---  사용 목적 : 검색속도(SELECT QUERY문을 사용하여 결과를 얻는데 걸리는 시간)를 빠르게 하는 것이 목적
---  APPLICATION 개발 단계에서는 TABLE의 PRIMARY KEY등에 적용되고, 
--   본격적으로 INDEX를 사용하는 것은 시스템이 오픈되고 난 후 운영단계에서 사용됨
--   - index는 내부적으로 tree구조 모양으로 데이터를 생성하고 관리
--   - 단점 : 원래 데이터 이외의 검색속도를 빠르게 하기 위한 부가 정보를 추가 생성해서 관리해야 함
--    (별도 메모리, 하드 용량 엄청 잡아먹음, 함부로 사용하면 안됨. 검색 외에 조회, 생성, 삭제 등 사용시 많이 느려짐.)
--  
--   JAVA에서
--   String[] name = new String[100,000];
--  
--   - name 1차원 배열에서 사람이름을 등록하고, 특정 사람을 찾을 경우 최대 10,000,000번씩
--   => 평균 5,000,000번 검색

-- Index 사용하기
-- 테이블의 PRIMARY KEY로 절정된 COLUMN(속성)은 기본적으로 INDEX가 설정되어 있음
-- 예를 들면, EMP 테이블의 PRIMARY KEY로 설정된 EMPNO는 INDEX가 자동 ㅅ러정되어 있음
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN ('EMP', 'DEPT');

-- 인덱스 설정 전과 인덱스 설정 후의 조회 속도 비교
DROP TABLE EMP01;

CREATE TABLE EMP01
AS
SELECT * FROM EMP;

SELECT * FROM EMP01;

INSERT INTO EMP01
SELECT * FROM EMP01; -- 40만개 생성 후 시간 체크함

INSERT INTO EMP01 (EMPNO, ENAME)
VALUES (1111, 'SYJ');

-- 시간 체크하는 명령어
SET TIMING ON

SELECT DISTINCT EMPNO, ENAME
FROM EMP01
WHERE ENAME='SYJ';

-- INDEX 생성 : ORACLE 내부적으로 B-TREE에 대한 정보를 추가 생성
CREATE INDEX IDX_EMP01_ENAME
ON EMP01(ENAME);

SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN ('EMP01');

-- 생성한 INDEX를 사용하는 곳은 SELECT명령어의 WHERE 조건절 내부에서 주로 사용
-- 기본키로 설정된 속성으로 WHERE 조건절에서 사용하여 검색할 경우에는 기본적으로 속도가 매우 빠름
SELECT DISTINCT EMPNO, ENAME
FROM EMP01
WHERE ENAME='SYJ'; -- 빨라졌음

-- INDEX 삭제하기
DROP INDEX IDX_EMP01_ENAME;
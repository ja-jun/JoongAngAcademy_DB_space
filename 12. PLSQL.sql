-- 21.12.15
-- PL/SQL : Oracle's Procedural Language extension to SQL
-- Procedural Language : 절차 언어는 통상 C 언어를 의미 (Java : Object Oriented Language)
-- SQL명령어를 사용해서 if/while 제어문, 변수 선언 등을 사용하여 코딩을 할 수 있다는 의미임
-- C LANGUAGE 또는 pascal LANGUAGE ( { = begin 의미 ), ( } = end 의미 )

-- 오라클 PL/SQL로 짠 프로그램 결과값을 CONSOLE에게 출력하라고 설정하는 명령어
set serveroutput on

BEGIN 
-- dbms_output.put_line : System.out.println과 같은 기능
-- 명령어 마다 끝에 ; 을 붙여야만 함
    dbms_output.put_line('HELLO, PLSQL');
END;
/ 
-- / : PL/SQL 프로그램이 종료된다는 기호

-- 2번째 프로그램 : 변수 선언하여 사용하기
-- DECLARE
--
-- BEGIN
--
-- END;
-- /
-- 위의 것이 뼈대

-- DECLARE : 변수 선언할 때 사용하는 키워드
DECLARE
-- 변수이름 + 변수데이터타입
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(10);
BEGIN
    VEMPNO := 7788;
    VENAME := 'SCOTT';
    dbms_output.put_line('사번 / 이름'); 
    dbms_output.put_line('-----------------');
    dbms_output.put_line(VEMPNO || '/' || VENAME);
END;
/

-- SELECT 문을 사용하여 사번과 이름 검색하기
-- EMP.EMPNO%TYPE => VEMPNO의 데이터 타입을 선언
DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
BEGIN
    dbms_output.put_line('사번 / 이름'); 
    dbms_output.put_line('-----------------');
    SELECT EMPNO, ENAME INTO VEMPNO, VENAME 
        FROM EMP 
        WHERE ENAME='SCOTT';
    dbms_output.put_line(VEMPNO || '/' || VENAME);
END;
/

-- 21.12.16
-- PL/SQL문 실행 @ 키워드 사용
@C:\DevSpace\DBSpace\PLSQL01Ex.sql;

@C:\DevSpace\DBSpace\PLSQLEx02.sql;

@C:\DevSpace\DBSpace\PLSQLEx03.sql;

@C:\DevSpace\DBSpace\PLSQLEx04.sql;

@C:\DevSpace\DBSpace\PLSQLEx05.sql;
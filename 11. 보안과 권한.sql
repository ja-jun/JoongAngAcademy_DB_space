-- 21.12.15
-- 정보 보안(Information Security)
-- 핵심 키워드 : 
-- 1) Authentication (시스템 사용 인증, login ID와 password로 관리)
-- 2) Authorization(시스템 사용 권한) => 사용자마다 시스템을 사용할 수 있는 화면, 권한이 다 틀림
--  예로, 사원의 가족 정보 등 인사정보를 수정할 수 있는 권한은 인사팀의 특정 몇몇 사람들에게만 부여

-- Oracle
-- 1) Authentication : Madang user가 있으면 password를 madang으로 입력해야지만 madang DB사용 가능
-- 2) Authorization : Table 마다 insert, update, select 등 개별 커멘드 사용 권한을 부여 가능(오늘 배울 내용)

-- 1. 사용자 생성하기 전에 table sapce 생성하기

-- sys 또는 system에서 table space 생성 가능
-- md_tbs : table space 이름
-- 하드디스크에 oracle이 설치되어 있는 서브 디렉토리에 database로 사용할 파일을 신규 생성

-- table space 생성하기
CREATE TABLESPACE md_tbs
    datafile 'C:\oraclexe\app\oracle\oradata\XE\md_tbs_data01.dbf'
    size 10m;
    
CREATE TABLESPACE md_test
    datafile 'C:\oraclexe\app\oracle\oradata\XE\md_test_data01.dbf'
    size 10m;
-- table sapce 삭제하기
drop tablespace md_test
    including contents and datafiles;
    
-- user 생성하기
-- 접속불가
drop user mdguest;

create user mdguest
        identified by mdguest;
        
create user mdguest2
        identified by mdguest2
        default tablespace md_tbs;
        
-- mdguest에 오라클에 로그인 할 수 있는 권한(connect), 테이블 등 생성 권한(resource) 부여
-- 권한 : Authorization
-- SYS가 mdguest 사용자에게 connect, resource 권한을 부여
grant connect, resource to mdguest;
grant connect, resource to mdguest2;        
        
-- SQL 명령어 : 1) DDL(CREATE TABLE0, 2) DML(INSERT, UPDATE)
--             3) DCL (DATA CONTROL LANGUAGE) : GRANT, REVOKE

-- madang 사용자로 변경
-- madang 사용자가 mdguest 사용자에게 book 테이블의 select 명령어만 사용할 수 있는 권한을 부여
grant select on book to mdguest;
-- madang 사용자가 mdguest 사용자에게 customer 테이블의 select, update 명령어만 사용할 수 있는 권한을 부여
grant select, update on customer to mdguest with grant option;
-- madang 사용자가 모든 사용자에게 orders table의 select 사용 권한 부여
grant select on orders to public;

-- revoke : 권한 철회
-- madang이 mdguest에게 book 테이블의 select 사용 권한을 철회
revoke select on book from mdguest;

revoke select on customer from mdguest;


-- oracle database를 사용자를 grouping이 가능함
-- 예를 들면, DBA , IT개발자, POWER USER(고객에서 IT를 조금더 사용하는 사용자), 일반사용자
-- 1) DBA(2명) : 모든 권한을 부여(1사람에게 부여)
-- 2) IT개발자(30명) : DATA BASE 생성, 등 몇 가지 권한을 제외한 모든 권한 부여
-- 3) POWER USER(20명) : 일부 테이블만 UPDATE 가능, 특정 몇개 테이블을 제외한 모든 테이블에서 SELECT 권한 부여
-- 4) 일반 사용자(1000명) : 몇 개의 테이블에 대해서만 SELECT 권한 부여

-- SYS 또는 SYSTEM 계정으로 이동
-- ROLE 생성하는 것은 SYS 또는 SYSTEM에서만 가능.
CREATE ROLE PROGRAMMER;
-- ROLE PROGRAMMER에게 TABLE, VIEW 생성 권한 부여
GRANT CREATE ANY TABLE, CREATE ANY VIEW TO PROGRAMMER;
--mdguest 사용자에게 programmer 역할(role)을 부여
GRANT PROGRAMMER TO MDGUEST;
-- 선생님이 수업시간에 안되서 넘어감...
grant select, insert on mdguest2.newtable to programmer;

-- programmer ROLE 삭제
drop role programmer;
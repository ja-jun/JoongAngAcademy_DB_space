-- 21.12.08 오후수업 Scott
select * from emp;

select empno, ename, sal from emp;

select empno, ename, sal from emp where sal > 3000;
select empno, ename, sal from emp where sal <= 3000;
-- <> : not의 의미임
select empno, ename, sal from emp where sal <> 3000;

select *
from emp
where deptno=10;

-- 급여가 1500 이하인 사원의 사원번호, 사원이름, 급여를 출력하는 SQL 문을 작성해보시오. 
select empno, ename, sal 
from emp 
where sal <= 1500;

-- FORD의 정보 가져오기
select empno, ename, sal 
from emp
where ename='FORD';

select empno, ename, sal
from emp
where ename='SCOTT';

-- 1982년 
select * 
from emp
where hiredate <= '1982/01/01';

select * 
from emp
where hiredate <= '82/01/01';

select * 
from emp
where hiredate <= '1982-01-01';

select * 
from emp
where hiredate <= '1982+01+01';

select *
from emp
where deptno=10 and job = 'MANAGER';

select *
from emp
where deptno=10 or job = 'MANAGER';

select * 
from emp
where not deptno=10;
-- 동일한 결과
select * 
from emp
where deptno IN (20,30,40);

select *
from emp
where sal >= 2000 and sal <= 3000;

select * 
from emp
where comm=300 or comm=500 or comm=1400;

select *
from emp
where sal between 2000 and 3000;

select *
from emp
where sal not between 2000 and 3000;

select *
from emp
where hiredate between '1981/01/01' and '1981/12/31';

-- 21.12.09 오전 수업(4장)
select * from emp;

select *
from emp
where comm in(300, 500, 1400);

select empno, ename
from emp
where empno in (7521, 7654, 7844);

select empno, ename
from emp
where empno not in (7521, 7654, 7844);

-- where 조건문에서 영문자열을 검색할 때, 대소문자가 구분됨
select *
from emp
where ename like 'F%';

select *
from emp
where ename like 'J%';

select *
from emp
where ename like '%A%';

select * 
from emp
where ename like '%N';

select *
from emp
where ename like '__A%';

select * 
from emp
where ename not like '%A%';

select *
from emp
where comm = null;

-- where 조건문에서 null이 있는 속성값을 찾을 때
-- => is null을 사용해야 함
-- => 속성이름 = null을 사용하지 못하는 이유:
-- null이 어떤 값인지 결정되지 않아 = 연산자 사용 불가
select *
from emp
where comm is null;

select *
from emp
where comm is not null;

select *
from emp
where mgr is null;

--기본이 오름차순
select *
from emp
order by sal;

select *
from emp
order by sal asc;

select *
from emp
order by comm asc;

select *
from emp
order by comm desc;

select empno,  ename, job, hiredate
from emp
order by hiredate desc;

-- sal 내림차순 중 sal 같은 경우 ename 오름차순으로 함
select *
from emp
order by sal desc, ename asc;

-- 5장 SQL 주요함수 DUAL
-- .table 이름, 화면에서 단순 확인하기 위해서 사용하는 테이블
-- 'Hello, Oracle' 이런거 단순히 쓸때(아무의미없이)
-- DESC + tagle 이름 => table의 상세 정보를 화면에 출력
-- DESC : describe 표기하다, 표현하다 약자
-- 1. 숫자함수
desc dual;
desc emp;
-- 오라클의 한계 (항상 테이블 형식으로 나온다)
-- 단순 연산
select 30*50
from dual;

--sysdate : 오늘 날짜를 구하는 키워드
select sysdate
from dual;

select -10, abs(-10)
from dual;
-- floor(바닥) : 실수에서 소숫점 자리를 전부 제거한 수를 결과값으로 return
select 34.5678, floor(34.5678)
from dual;

-- ceil(천장) : 실수에서 소수점 자리의 최대값은 정수값에 34에 + 1 한 값을 return(반올림x)
select 34.5678, CEIL(34.1234)
from dual;

-- round : 실수값을 반올림하는 함수
select 34.5678, round(34.4678)
from dual;
-- round(실수값, 소숫점 자리수) 
-- 1. 소숫점 자리수가 양수인 경우는 소숫점 이하의 자리수를 의미(반올림해서 소숫점 자리까지 return)
-- 2. 소숫점 자리수가 음수인 경우는 소숫점 이상의 자리수를 의미
select 34.5678, round(34.4678, 2)
from dual;
select 34.5678, round(34.4678, -1)
from dual;
select 34.5678, round(1235.4678, -2)
from dual;

-- trunc(실수값, 소숫점자리수) : 반올림없이 소숫점자리수 이하는 무조건 삭제
-- trunc : truncate (자르다) 
select trunc(34.5678, 2), trunc(34.5678, -1), trunc(34.5678), trunc(34.5678, 0) 
from dual;

-- 나머지 구하는 함수 : mod
select mod(27, 2), mod(27, 5), mod(27, 7)
from dual;

-- 사원번호가 홀수인 사람들만 가져오기
select * from emp
where mod(empno, 2) = 1;
-- 사원번호가 짝수인 사람은?
select * from emp
where mod(empno, 2) = 0;

-- 2. 문자함수
-- 문자 처리 함수
-- UPPER : 모든 문자를 대문자로 변환하는 함수 (쉬우면서도 아주 많이 사용하는 함수)
select 'Welcome to Oracle', upper('Welcome to Oracle')
from DUAL;
-- lower : 모든 문자를 소문자로 변환하는 함수
select 'Welcome to Oracle', LOWER('Welcome to Oracle')
from dual;

select * from emp where lower(ename)='miller';
select * from emp where upper(ename)='MILLER';
-- length : 문자열의 길이를 구하는 함수 (영문, 한글 모두 단어 갯수 의미)
select length('Oracle'), length('오라클')
from dual;
-- lengthb : byte길이 (한글 1글자 = 3byte)
select length('Oracle'), lengthb('오라클')
from dual;

-- substr(문자열, 시작위치, 갯수) : 시작위치(index값이 아님)에서 갯수만큼 문자열 가져옴
select substr('Welcom to Oracle', 4, 3)
from dual;

select substr('Welcom to Oracle', -4, 3)
from dual;

select * from emp;

-- 9월 입사자가 누구누구지?
select * 
from emp
where substr(hiredate, 4, 2) = '09';
select * 
from emp
where substr(hiredate, 5, 1) = '9';

select substr(hiredate, 1, 2) 년, substr(hiredate, 4, 2) 월, substr(hiredate, 7, 2) 일
from emp;

-- 81년도 입사자
select *
from emp
where substr(hiredate, 1, 2) = '81';

select *
from emp
where substr(ename, -1, 1) = 'E';

select *
from emp
where lower(substr(ename, -1, 1)) = 'e';


-- instr(문자열, 찾고자하는 문자) => 찾고자 하는 문자의 첫번째 위치를 return
select instr('WELCOME TO ORACLE', 'O')
from dual;

-- instr(문자열, 찾고자하는 문자, 검색시작위치, 몇번째검색결과)
select instr('WELCOME TO ORACLE', 'O', 6, 2)
from dual;

-- 이름의 끝에서 3번째 자리의 문자가 T인 경우를 검색
select * 
from emp
where ename like '%T__';

-- 이름의 처음에서 3번째 자리의 문자가 R인 경우를 검색
select * 
from emp
where ename like '__R%';

select * 
from emp
where instr(ename, 'R', 3, 1) = 3;

-- 특정기호를 채우는 LPAD/RPAD
-- LPAD(문자열, 전체자리수, 전체자리수에서 문자열길이를 뺀 나머지 문자열을 채우는 문자) : oracle 6개를 뺀 # 14개 출력
-- LPAD : left padding(채워넣다) rpad(오른쪽)
select lpad('Oracle', 20, '#')
from dual;
select lpad('Oracle', 20, '*')
from dual;
select rpad('Oracle', 20, '*')
from dual;

-- TRIM : 전체 공백 없애기
-- LTRIM RTRIM : 공백없애기
select ltrim('  Oracle    ') from dual;
select rtrim('  Oracle    ') from dual;
select ltrim('  Oracle    ') from dual;

-- 날짜 함수
select sysdate from dual;

select sysdate-1 어제, sysdate 오늘, sysdate+1 내일
from dual;

-- 사원들의 근무일수
select sysdate-hiredate 근무일수
from emp;
select round(sysdate-hiredate, 2) 근무일수
from emp;
-- 퇴직금 계산 등
select hiredate, round(hiredate, 'MONTH')
from emp;

select hiredate, trunc(hiredate, 'MONTH')
from emp;

select ename, sysdate, hiredate, MONTHS_between (sysdate, hiredate)
from emp;

select sysdate, next_day(sysdate, '수요일')
from dual;

select hiredate, last_day(hiredate)
from emp;

-- TO_CHAR : 문자를 숫자로 변환
select hiredate, TO_CHAR(hiredate, 'YYYY/MM/DD DAY')
from emp;

select hiredate, TO_CHAR(hiredate, 'YY/MM/DD DY')
from emp;

select to_char(sysdate, 'yyyy/mm/dd hh24 : mi : ss')
from dual;

-- to_char 숫자를 문자열로 변환
select to_char(1230000)
from dual;

select ename, sal, to_char(sal, 'L999,999')
from emp;
-- L : 천의 기호(1,000)
select ename, sal, to_char(sal, 'L999,999'), to_char(sal, 'l000,000')
from emp;

-- TO_DATE date type(hiredate), number type(19810220) error 발생
select ename, hiredate
from emp
where hiredate=19810220;

select ename, hiredate
from emp
where hiredate=to_date(19810220, 'yyyy/mm/dd');

select ename, hiredate
from emp
where hiredate=to_date('1981-02-20', 'yyyy/mm/dd');

select ename, hiredate
from emp
where hiredate=to_date('1981-02-20', 'yyyy/mm/dd');

select ename, hiredate
from emp
where hiredate='1981-02-20';

-- TO_NUMBER
select to_number('20,000', '99,999') - to_number('10,000', '99,999')
from dual;

select * from emp;

-- 숫자와 null에 대하여 산술연산하면 결과값이 null이 나옴(값이 정해지지않았다 0 or 무한대)
select ename, sal, comm, sal*12+comm 연봉
from emp;
-- nvl 함수 : null value의 약어로 null일 때 default값 설정
select ename, sal, comm, sal*12+nvl(comm, 0) 연봉
from emp;

select * from emp;

select sum(sal) from emp;
-- sum : 속성값이 null인 경우는 0으로 변환하여 계산
select sum(comm) from emp;

select trunc(avg(sal), 2) from emp;

select max(sal), min(sal) from emp;
-- error : 직계함수(1개)와 ename(여러개)하고 쓸수없다. 오라클이 표현을 할 수 없다.
select ename, max(sal) from emp;

-- count(속성) : 속성 값이 null이 아닌 속성 갯수
select count(*), count(comm) from emp;

select distinct job from emp;

select count(job), count(distinct job) from emp;

-- date type에도 집계함수 사용 가능
select max(hiredate) 최근입사일자, min(hiredate) 최초입사일자
from emp;

-- group by
select deptno
from emp
group by deptno;

select deptno, trunc(avg(sal), 2)
from emp
group by deptno;

-- error : group by에서 지정된 속성이름과 집계함수만 select에서 사용 가능
select ename, deptno, trunc(avg(sal), 2)
from emp
group by deptno;

select deptno, trunc(avg(sal), 2), max(sal), min(sal), count(*) 사원수
from emp
group by deptno;


select deptno, trunc(avg(sal), 2)
from emp
group by deptno
having avg(sal) >= 2000;

select deptno, max(sal), min(sal)
from emp
group by deptno
having max(sal) > 2900;

select * from emp;
select * from dept;

-- join 실습
-- 사원 이름과 부서이름?
select ename, emp.deptno, dname
from emp, dept
where emp.deptno=dept.deptno;

select ename, dname
from emp, dept
where emp.deptno=dept.deptno and ename='SCOTT';

select e.ename, d.dname, e.deptno, d.deptno 
from emp e, dept d
where e.deptno = d.deptno
and e.ename = 'SCOTT';

-- 1. 뉴욕근무 사원이름과 급여
select ename, sal
from emp, dept
where emp.deptno = dept.deptno and dept.loc='NEW YORK';

-- 2. Accounting 부서 사원이름, 입사일 출력
select ename, hiredate
from emp, dept
where emp.deptno = dept.deptno and dept.dname = 'ACCOUNTING';

-- 3. 직급이 manager인 사원 이름과 부서
select ename, dname
from emp, dept
where emp.deptno = dept.deptno and emp.job = 'MANAGER';

select * from salgrade;

select * from emp, salgrade;

select *
from emp, salgrade
where sal between losal and hisal;

select ename, sal, grade
from emp, salgrade
where sal between losal and hisal;

select *
from emp, dept, salgrade
where emp.deptno = dept.deptno and sal between losal and hisal;

select ename, dname, grade
from emp, dept, salgrade
where emp.deptno = dept.deptno and sal between losal and hisal;

-- self join : 본인 table을 본인이 join
select e.ename || '의 매니져는 ' || m.ename || '입니다.'
from emp e, emp m
where e.mgr = m.empno;

select * from emp;

select * from emp e, emp m;

-- 4. 매니저가 king인 사원들의 이름과 직급을 출력하시오
select e.ename, e.job
from emp e, emp m
where e.mgr = m.empno and m.ename = 'KING';

-- 5. scott과 동일한 근무지에서 근무하는 사원의 이름을 출력하시오
select f.ename
from emp e, emp f
where e.deptno = f.deptno and e.ename = 'SCOTT' and f.ename<>'SCOTT';


-- LEFT OUTER JOIN 오라클 스타일
select e.ename || '의 매니져는 ' || m.ename || '입니다.'
from emp e, emp m
where e.mgr = m.empno(+);

-- ANSI JOIN 예제
-- 1. CROSS JOIN (Cartesian Product)
select *
from emp cross join dept;

-- 2. Inner JOIN (EUQI-JOIN과 똑같다)
select ename, dname
from emp inner join dept
on emp.deptno = dept.deptno;
-- EUQI-JOIN
select ename, dname
from emp, dept
where emp.deptno = dept.deptno;
 
select ename, dname
from emp inner join dept 
on emp.deptno = dept.deptno
where ename='SCOTT';

-- using 사용
select ename, dname
from emp inner join dept 
using (deptno);

select ename, dname
from emp inner join dept 
using (deptno)
where ename='SCOTT';

-- 3. Natural Join 하나가 삭제된다.
-- => equi join 결과에서 2개인 deptno 속성을 1개로 줄여줌
select *
from emp natural join dept;
-- 위는 natural join 아래는 equi join
select *
from emp inner join dept
on emp.deptno = dept.deptno;

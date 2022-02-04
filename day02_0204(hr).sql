-- 연습문제 : 작성자 김동훈

--1 . jobs 테이블 문제
 
--1) min_salary 컬럼이 10000이상인 job_title 조회
SELECT MIN_SALARY 
FROM JOBS WHERE min_salary >= 10000;

--2) job_title 컬럼이 programmer인 행의 모든 컬럼 조회
SELECT * FROM JOBS WHERE JOB_TITLE = 'Programmer';
-- 대소문자 구분없이 한다면 문자열 관련 오라클 함수 : upper(), lower()
SELECT * FROM JOBS WHERE upper(JOB_TITLE) = 'PROGRAMMER';
SELECT * FROM JOBS WHERE LOWER(JOB_TITLE) = 'programmer';

--3) max_salary 컬럼의 최대값 조회
SELECT MAX(MAX_SALARY)
FROM JOBS;

-- 추가 : min_salary 의 평균값보다 작은 행의 job_title 컬럼 조회 -> group 진도 후 다시 해봅시다.
SELECT job_id , job_title FROM jobs WHERE MIN_SALARY < AVG(MIN_SALARY); 


--2. locations 테이블 문제

--1) city 필드값이 London인 postal_code 조회
SELECT POSTAL_CODE 
FROM LOCATIONS WHERE CITY = 'London';
SELECT POSTAL_CODE 
FROM LOCATIONS WHERE CITY = 'Seattle';

--2) LOCATion_id 컬럼이 1700 ,2700 , 2500이 아니고 city 컬럼이 tokyo인 해의 모든 컬럼 조회
SELECT *
FROM LOCATIONS WHERE LOCATION_ID NOT IN(1700,2500,2700)
AND CITY = 'Tokyo';

--3. employees 테이블
-- 동계함수(집계 함수) 를 좀더 연습합니다.
SELECT COUNT(*) FROM EMPLOYEES e;  -- 총개수 : 107
SELECT COUNT(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; -- 조건 job_id 직원수 : 5

SELECT AVG(salary) FROM EMPLOYEES e; -- 직원 평균급여 : 6461.831
SELECT AVG(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; -- 조건 job_id 평균급여 : 5760 

SELECT MAX(salary) FROM EMPLOYEES e; -- 직원 중 최고급여 : 24,000
SELECT MAX(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; -- 조건 job_id 최고급여 : 9000

SELECT MIN(salary) FROM EMPLOYEES e; -- 직원 중 최저급여 : 2,100
SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; -- 조건 job_id 최저급여 : 4,200

-- 통계함수는 그룹함수입니다. 해당함수 결과값을 구하기위해 여러 데이터들을 그룹화하고 실행합니다.
-- 그룹함수 결과와 다른 칼럼을 같이 조회할 수 없습니다. 아래 sql은 오류 입니다.
SELECT JOB_ID , MAX(salary) FROM EMPLOYEES e;

SELECT * FROM EMPLOYEES e2 WHERE SALARY = (
-- 위의 avg,max,min 구한 sql명령을 하나씩 여기에 넣어보세요. 그 의미를 파악해 봅시다.
--SELECT max(salary) FROM EMPLOYEES e
--SELECT MAX(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'
--SELECT MIN(salary) FROM EMPLOYEES e
SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'
); -- SELECT 안에 쓰인 또 다른 SELECT 는 서브쿼리입니다. 서브쿼리 결과값이 1개이므로 = 조건식에 사용할 수 있습니다.

-- IT_PROG 중에서 최소급여를 받는 사람의 first_name, last_name 컬럼 조회하기
SELECT FIRST_NAME ,LAST_NAME FROM EMPLOYEES e
WHERE SALARY = (SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG')
	AND JOB_ID = 'IT_PROG';


--추가 : min_salary 의 평균값보다 작은 행의 job_id ,job_title 컬럼 조회 
-- 		아래 명려은 오류 -> 그룹함수는 반드시 SELECT 문으로 사용합니다.
SELECT job_id ,job_title FROM JOBS j2 WHERE MIN_SALARY < 
(SELECT AVG(MIN_SALARY) FROM JOBS j);

-- 평균값
SELECT AVG(min_salary) FROM JOBS j;
-- 평균값을 조건식에 이용하기 (서브쿼리)
SELECT job_id , job_title , min_salary FROM jobs j
WHERE MIN_SALARY < (SELECT AVG(MIN_SALARY) FROM JOBS j);


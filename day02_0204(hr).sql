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
FROM LOCATIONS WHERE CITY = 'Seattle';

--2) LOCATion_id 컬럼이 1700 ,2700 , 2500이 아니고 city 컬럼이 tokyo인 해의 모든 컬럼 조회
SELECT *
FROM LOCATIONS WHERE LOCATION_ID NOT IN(1700,2500,2700)
AND CITY = 'Tokyo';





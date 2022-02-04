-- �������� : �ۼ��� �赿��

--1 . jobs ���̺� ����
 
--1) min_salary �÷��� 10000�̻��� job_title ��ȸ
SELECT MIN_SALARY 
FROM JOBS WHERE min_salary >= 10000;

--2) job_title �÷��� programmer�� ���� ��� �÷� ��ȸ
SELECT * FROM JOBS WHERE JOB_TITLE = 'Programmer';
-- ��ҹ��� ���о��� �Ѵٸ� ���ڿ� ���� ����Ŭ �Լ� : upper(), lower()
SELECT * FROM JOBS WHERE upper(JOB_TITLE) = 'PROGRAMMER';
SELECT * FROM JOBS WHERE LOWER(JOB_TITLE) = 'programmer';

--3) max_salary �÷��� �ִ밪 ��ȸ
SELECT MAX(MAX_SALARY)
FROM JOBS;

-- �߰� : min_salary �� ��հ����� ���� ���� job_title �÷� ��ȸ -> group ���� �� �ٽ� �غ��ô�.
SELECT job_id , job_title FROM jobs WHERE MIN_SALARY < AVG(MIN_SALARY); 


--2. locations ���̺� ����

--1) city �ʵ尪�� London�� postal_code ��ȸ
SELECT POSTAL_CODE 
FROM LOCATIONS WHERE CITY = 'London';
FROM LOCATIONS WHERE CITY = 'Seattle';

--2) LOCATion_id �÷��� 1700 ,2700 , 2500�� �ƴϰ� city �÷��� tokyo�� ���� ��� �÷� ��ȸ
SELECT *
FROM LOCATIONS WHERE LOCATION_ID NOT IN(1700,2500,2700)
AND CITY = 'Tokyo';





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
SELECT POSTAL_CODE 
FROM LOCATIONS WHERE CITY = 'Seattle';

--2) LOCATion_id �÷��� 1700 ,2700 , 2500�� �ƴϰ� city �÷��� tokyo�� ���� ��� �÷� ��ȸ
SELECT *
FROM LOCATIONS WHERE LOCATION_ID NOT IN(1700,2500,2700)
AND CITY = 'Tokyo';

--3. employees ���̺�
-- �����Լ�(���� �Լ�) �� ���� �����մϴ�.
SELECT COUNT(*) FROM EMPLOYEES e;  -- �Ѱ��� : 107
SELECT COUNT(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; -- ���� job_id ������ : 5

SELECT AVG(salary) FROM EMPLOYEES e; -- ���� ��ձ޿� : 6461.831
SELECT AVG(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; -- ���� job_id ��ձ޿� : 5760 

SELECT MAX(salary) FROM EMPLOYEES e; -- ���� �� �ְ�޿� : 24,000
SELECT MAX(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; -- ���� job_id �ְ�޿� : 9000

SELECT MIN(salary) FROM EMPLOYEES e; -- ���� �� �����޿� : 2,100
SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; -- ���� job_id �����޿� : 4,200

-- ����Լ��� �׷��Լ��Դϴ�. �ش��Լ� ������� ���ϱ����� ���� �����͵��� �׷�ȭ�ϰ� �����մϴ�.
-- �׷��Լ� ����� �ٸ� Į���� ���� ��ȸ�� �� �����ϴ�. �Ʒ� sql�� ���� �Դϴ�.
SELECT JOB_ID , MAX(salary) FROM EMPLOYEES e;

SELECT * FROM EMPLOYEES e2 WHERE SALARY = (
-- ���� avg,max,min ���� sql����� �ϳ��� ���⿡ �־����. �� �ǹ̸� �ľ��� ���ô�.
--SELECT max(salary) FROM EMPLOYEES e
--SELECT MAX(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'
--SELECT MIN(salary) FROM EMPLOYEES e
SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'
); -- SELECT �ȿ� ���� �� �ٸ� SELECT �� ���������Դϴ�. �������� ������� 1���̹Ƿ� = ���ǽĿ� ����� �� �ֽ��ϴ�.

-- IT_PROG �߿��� �ּұ޿��� �޴� ����� first_name, last_name �÷� ��ȸ�ϱ�
SELECT FIRST_NAME ,LAST_NAME FROM EMPLOYEES e
WHERE SALARY = (SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG')
	AND JOB_ID = 'IT_PROG';


--�߰� : min_salary �� ��հ����� ���� ���� job_id ,job_title �÷� ��ȸ 
-- 		�Ʒ� ����� ���� -> �׷��Լ��� �ݵ�� SELECT ������ ����մϴ�.
SELECT job_id ,job_title FROM JOBS j2 WHERE MIN_SALARY < 
(SELECT AVG(MIN_SALARY) FROM JOBS j);

-- ��հ�
SELECT AVG(min_salary) FROM JOBS j;
-- ��հ��� ���ǽĿ� �̿��ϱ� (��������)
SELECT job_id , job_title , min_salary FROM jobs j
WHERE MIN_SALARY < (SELECT AVG(MIN_SALARY) FROM JOBS j);


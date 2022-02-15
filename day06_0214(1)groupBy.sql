-- �����Լ�(����Լ�,�׷��Լ�) : conun, MAX, MIN, SUM, AVG�ܿ� �л�, ǥ������, �߾Ӱ� ���� �Լ��� ����

--group by : Ư�� �÷����� �׷�ȭ�ϰ� �׿� ���ؼ� �����Լ��� �����մϴ�.
--����) �μ��� �������, ������ ������, �μ��� ������...

--�׷��Լ� ����
SELECT COUNT(*), avg(salary)
FROM EMPLOYEES e 
WHERE JOB_ID = 'IT_PROG';
--���� : �׷��Լ� ����� �Ϲ�Į���� �Բ� ��ȸ �� �մϴ�.
SELECT JOB_ID,COUNT(*), avg(salary)
FROM EMPLOYEES e 
WHERE JOB_ID = 'IT_PROG';

-- group by�� �����Ͽ� ���������� count, avg ���մϴ�.
SELECT JOB_ID ,COUNT(*), avg(salary)
FROM EMPLOYEES e 
group by JOB_ID;

-- �μ��� count, avg (�׷��Լ� ��� �Բ� ��ȸ�� �� �ִ� �÷��� �׷�ȭ �÷��� �����մϴ�.)
SELECT DEPARTMENT_ID ,COUNT(*) AS "�ο���" ,AVG(salary) AS average
FROM EMPLOYEES e 
group BY DEPARTMENT_ID;

-- departments ���̺�� ���� �μ��� ���踦 join -> �μ��� ��ȸ (��)
SELECT e.DEPARTMENT_ID, d.DEPARTMENT_NAME ,COUNT(*) AS "�ο���",AVG(SALARY) AS average  
FROM EMPLOYEES e join DEPARTMENTS d
ON e.EMPLOYEE_ID = d.DEPARTMENT_ID
group BY e.DEPARTMENT_ID, d.DEPARTMENT_NAME; 

-- departments ���̺�� ���� �μ��� ���踦 join -> �μ��� ��ȸ (�����)
SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, d2."�ο���",d2."���" 
FROM DEPARTMENTS d ,
		(SELECT DEPARTMENT_ID ,COUNT(*) AS "�ο���" ,AVG(salary) AS "���"
		FROM EMPLOYEES e  
		group BY DEPARTMENT_ID) d2
WHERE d.DEPARTMENT_ID = d2.DEPARTMENT_ID;

-- ��ȸ��� ��µǴ� ���� ������ �ο��� ��������
SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, d2."�ο���",d2."���" 
FROM DEPARTMENTS d ,
		(SELECT DEPARTMENT_ID ,COUNT(*) AS "�ο���" ,AVG(salary) AS "���"
		FROM EMPLOYEES e  
		group BY DEPARTMENT_ID) d2
WHERE d.DEPARTMENT_ID = d2.DEPARTMENT_ID
ORDER BY d2."�ο���" DESC;   --�������� dese

-- ��ձ޿� ��������
SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, d2."�ο���",d2."���" 
FROM DEPARTMENTS d ,
		(SELECT DEPARTMENT_ID ,COUNT(*) AS "�ο���" ,AVG(salary) AS "���"
		FROM EMPLOYEES e  
		group BY DEPARTMENT_ID) d2
WHERE d.DEPARTMENT_ID = d2.DEPARTMENT_ID
ORDER BY d2."���";

-- �ڸ��� ���� �Լ� : ���� trunc , �ø� ceil, �ݿø� round 
SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, d2."�ο���",d2."���" 
FROM DEPARTMENTS d ,
		(SELECT DEPARTMENT_ID ,COUNT(*) AS "�ο���" ,ROUND(AVG(salary),0) AS "���"
		FROM EMPLOYEES e  
		group BY DEPARTMENT_ID) d2
WHERE d.DEPARTMENT_ID = d2.DEPARTMENT_ID
ORDER BY d2."���";

-- �ڸ��� ���� �Լ� : ���� trunc, �ø� ceil, �ݿø� round -> �Ҽ������� �ڸ��� ����

-- ���� group by ������� ��ձݾ��� 8000 �̻��� �μ��� ��ȸ�Ѵٸ�?
SELECT DEPARTMENT_ID ,COUNT(*) AS "�ο���" ,ROUND(AVG(salary),0) AS "���"
FROM EMPLOYEES e
--WHERE e."���" > 8000  -- ���� : �����Լ� ��������� WHERE ���X
group BY DEPARTMENT_ID
HAVING avg(SALARY) > 8000 -- HAVING : �����Լ� ��������� ���ǽ��� ���� ��밡���մϴ�. �Ϲ��÷��� ����
ORDER BY "���";

-- ���� : from -> WHERE -> GROUP by -> HAVING -> order by

-- ALL Ű���� : job_id �� ST_CLERT�� ��� �������� �޿����� ���� �޴� ������ ��ȸ
-- 			���� ����� max ������ ū���� ã�� ��. -> ALL Ű����� �ٲ㺸�� 
SELECT max(salary) from EMPLOYEES e WHERE JOB_ID = 'ST_CLERK';

-- ���� salary �÷����� �����ϰ� ���ǿ� �´� �͸� �����մϴ�.
SELECT last_name, salary, job_id FROM EMPLOYEES e 
WHERE SALARY > all(SELECT SALARY FROM EMPLOYEES e2 WHERE JOB_ID = 'ST_CLERK');

-- EMPLOYEES ���̺� ���� ������ ���� max ������ ū�͸� ����� �����մϴ�.
SELECT last_name, salary, job_id FROM EMPLOYEES e 
WHERE SALARY > (SELECT MAX(SALARY) FROM EMPLOYEES e2 WHERE JOB_ID = 'ST_CLERK');

SELECT * FROM EMPLOYEES e;


















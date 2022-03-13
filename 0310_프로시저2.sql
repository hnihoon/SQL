/*
 * SQL> connect system/1234
 * SQL> alter user hr account unlock;
 * SQL> alter user hr identified by hr;
 * 
 */
-- hr ��Ű���� ���̺��� �̿��ؼ� ���ν��� �����մϴ�.

SELECT * FROM EMPLOYEES e ;
SELECT * FROM DEPARTMENTS d ;

-- Sales �μ��� �ְ� �����ݾ���?
SELECT max(SALARY) FROM EMPLOYEES e ,DEPARTMENTS d 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND d.DEPARTMENT_NAME ='Sales';

-- ���� join���� ��ȸ�� ���� ���ν��� Ȱ���ؼ� ���ϱ�
DECLARE
	--dept_id departments.department_id%TYPE;
	dept_id NUMBER;
	max_sal NUMBER;			-- ������Ÿ�� ũ�� ����.
	emp EMPLOYEES%ROWTYPE;
BEGIN
	-- Sales �μ��� �μ�ID���ϱ�
	SELECT DEPARTMENT_ID 
	INTO dept_id 			-- ������ ����.
	FROM DEPARTMENTS d WHERE DEPARTMENT_NAME ='IT';
	-- ������ �μ�ID�� �������̺��� �ְ� �����ݾ� ���ϱ�
	SELECT max(salary) 
	INTO  max_sal	-- ������ �����ϱ�
	FROM EMPLOYEES e WHERE DEPARTMENT_ID =dept_id;		--������ ���ǽĿ� Ȱ��
	DBMS_OUTPUT.PUT_LINE('�ְ� �����ݾ�(Sales�μ�) : ' || max_sal);
	-- �߰�: 'Sales'�μ��� �ְ����ݾ��� �޴� ������ �������ϱ� (�� ��ü�� ������ ����)
	SELECT * 
	INTO emp		-- rowtype ������ ��ȸ��� ��� �÷��� ����.
	FROM EMPLOYEES e 
	WHERE DEPARTMENT_ID =dept_id AND e.SALARY =max_sal;
	DBMS_OUTPUT.PUT_LINE('Sales �ְ��� ���� : ' || emp.last_name || ',' || emp.hire_date);
END;

SELECT * FROM EMPLOYEES e 
	WHERE DEPARTMENT_ID =80 AND e.SALARY =14000;

SELECT DEPARTMENT_ID 
FROM DEPARTMENTS d WHERE DEPARTMENT_NAME ='Sales';
SELECT max(salary) 
FROM EMPLOYEES e WHERE DEPARTMENT_ID =80;


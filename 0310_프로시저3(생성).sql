-- ���ν����� begin ~ end; ������ SQL ��ɵ��� �������� ��찡 ��κ� �� �������� ��ɾ �ϳ��� ������ ó���մϴ�.
-- Ʈ������ : �ϳ��� ������ ó���ϴ� SQL ��ɹ� -> ��� �������Ǿ�� �մϴ�.(commit) �׷��� ������(�ϳ��� ������ �����)
-- 			�̹� ����� SQL����� ��Ұ� �Ǿ�� �մϴ�(rollback)


-- ���ν����� ����Ŭ ��ü�� �����ϸ� ȣ���ؼ� �ٽ� ������ �� �ֽ��ϴ�.
/* �⺻����
CREATE OR REPLACE dept_max_salary(

)
IS
BEGIN 
	
	
END;

*/
-- ���ν����� ������ �� create : ������ �����, replace : ������ ��ü�ϱ�
CREATE OR REPLACE PROCEDURE dept_max_salary(
	--�Ű������� �����ϴ� ��ġ : IN�� �Է� �Ű������μ� ������ �� ���޵Ǵ� ���� �����ϴ� �����Դϴ�.
	dept_name IN departments.DEPARTMENT_NAME %TYPE :=''  	--���Թ� := ���� �ʱ�ȭ
)
IS
	-- �ʿ��� ������ �����ϴ� ��ġ
	dept_id NUMBER(8);
	max_sal NUMBER(8);
	emp EMPLOYEES%ROWTYPE;
	
BEGIN 
	-- Sales �μ��� �μ�ID���ϱ�
	SELECT DEPARTMENT_ID 
	INTO dept_id 			-- ������ ����.
	FROM DEPARTMENTS d WHERE DEPARTMENT_NAME = dept_name;	-- �Է¸Ű����� �����ؼ� ����
	-- ������ �μ�ID�� �������̺��� �ְ� �����ݾ� ���ϱ�
	SELECT max(salary) 
	INTO  max_sal	-- ������ �����ϱ�
	FROM EMPLOYEES e WHERE DEPARTMENT_ID =dept_id;		--������ ���ǽĿ� Ȱ��
	DBMS_OUTPUT.PUT_LINE(dept_name || '�ְ� �����ݾ�(Sales�μ�) : ' || max_sal);
	-- �߰�: 'Sales'�μ��� �ְ����ݾ��� �޴� ������ �������ϱ� (�� ��ü�� ������ ����)
	SELECT * 
	INTO emp		-- rowtype ������ ��ȸ��� ��� �÷��� ����.
	FROM EMPLOYEES e 
	WHERE DEPARTMENT_ID =dept_id AND e.SALARY =max_sal;
	DBMS_OUTPUT.PUT_LINE(dept_name || 'Sales �ְ��� ���� : ' || emp.last_name || ',' || emp.hire_date);
END;

BEGIN 
dept_max_salary ('Sales');
END;

SELECT * FROM EMPLOYEES e;
-- �Ϲ� join SQL
SELECT d.department_id id, d.department_name dept, max_sal FROM departments d,
		(SELECT DEPARTMENT_ID id, max(salary) max_sal 
		FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID) max_sal#
	WHERE d.DEPARTMENT_ID = max_sal#.id AND d.DEPARTMENT_NAME = 'Sales'; 

	--�μ��� �ְ� ����
SELECT DEPARTMENT_ID id, max(salary) max_sal 
		FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID
		HAVING DEPARTMENT_ID = 80;

CREATE OR REPLACE PROCEDURE dept_max_salary2(
	dept_name IN hr.departments.DEPARTMENT_NAME %TYPE,
	-- ��� �Ű�����
	dept_id OUT hr.departments .department_id %TYPE,
	max_sal OUT NUMBER 
)
IS 
	vdept_id NUMBER(8);
BEGIN 
	SELECT d.department_id id 
	INTO vdept_id		-- ��ȸ��� ������ ����
	FROM departments d
	WHERE d.DEPARTMENT_NAME = 'Sales';

	SELECT DEPARTMENT_ID id, max(salary) 
	INTO dept_id, max_sal 
		FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID
		HAVING DEPARTMENT_ID = vdept_id;
END;

-- ������ �� ��� �Ű� ������ �����ؾ��մϴ�.
DECLARE
		dept_id hr.employees.department_id %TYPE;
		max_sal NUMBER;
BEGIN
dept_max_salary2('Sales',dept_id,max_sal);
DBMS_OUTPUT.PUT_LINE('�μ���' || ':'|| ',�����ݾ� : ' || max_sal);
END;

-- 프로시저의 begin ~ end; 사이의 SQL 명령들이 여러개인 경우가 대부분 그 여러개의 명령어가 하나의 업무를 처리합니다.
-- 트랜젝션 : 하나의 업무를 처리하는 SQL 명령문 -> 모두 정상실행되어야 합니다.(commit) 그렇지 않으면(하나라도 오류가 생기면)
-- 			이미 실행된 SQL명령은 취소가 되어야 합니다(rollback)


-- 프로시저를 오라클 객체로 생성하면 호출해서 다시 실행할 수 있습니다.
/* 기본형식
CREATE OR REPLACE dept_max_salary(

)
IS
BEGIN 
	
	
END;

*/
-- 프로시저를 생성할 때 create : 없으면 만들기, replace : 있으면 대체하기
CREATE OR REPLACE PROCEDURE dept_max_salary(
	--매개변수를 선언하는 위치 : IN은 입력 매개변수로서 실행할 때 전달되는 값을 저장하는 변수입니다.
	dept_name IN departments.DEPARTMENT_NAME %TYPE :=''  	--대입문 := 으로 초기화
)
IS
	-- 필요한 변수를 선언하는 위치
	dept_id NUMBER(8);
	max_sal NUMBER(8);
	emp EMPLOYEES%ROWTYPE;
	
BEGIN 
	-- Sales 부서의 부서ID구하기
	SELECT DEPARTMENT_ID 
	INTO dept_id 			-- 변수에 저장.
	FROM DEPARTMENTS d WHERE DEPARTMENT_NAME = dept_name;	-- 입력매개변수 대입해서 실행
	-- 구해진 부서ID로 직원테이블에서 최고 연봉금액 구하기
	SELECT max(salary) 
	INTO  max_sal	-- 변수에 저장하기
	FROM EMPLOYEES e WHERE DEPARTMENT_ID =dept_id;		--변수를 조건식에 활용
	DBMS_OUTPUT.PUT_LINE(dept_name || '최고 연봉금액(Sales부서) : ' || max_sal);
	-- 추가: 'Sales'부서의 최고연봉금액을 받는 직원의 정보구하기 (행 전체를 변수에 저장)
	SELECT * 
	INTO emp		-- rowtype 변수에 조회결과 모든 컬럼을 저장.
	FROM EMPLOYEES e 
	WHERE DEPARTMENT_ID =dept_id AND e.SALARY =max_sal;
	DBMS_OUTPUT.PUT_LINE(dept_name || 'Sales 최고연봉 직원 : ' || emp.last_name || ',' || emp.hire_date);
END;

BEGIN 
dept_max_salary ('Sales');
END;

SELECT * FROM EMPLOYEES e;
-- 일반 join SQL
SELECT d.department_id id, d.department_name dept, max_sal FROM departments d,
		(SELECT DEPARTMENT_ID id, max(salary) max_sal 
		FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID) max_sal#
	WHERE d.DEPARTMENT_ID = max_sal#.id AND d.DEPARTMENT_NAME = 'Sales'; 

	--부서별 최고 연봉
SELECT DEPARTMENT_ID id, max(salary) max_sal 
		FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID
		HAVING DEPARTMENT_ID = 80;

CREATE OR REPLACE PROCEDURE dept_max_salary2(
	dept_name IN hr.departments.DEPARTMENT_NAME %TYPE,
	-- 출력 매개변수
	dept_id OUT hr.departments .department_id %TYPE,
	max_sal OUT NUMBER 
)
IS 
	vdept_id NUMBER(8);
BEGIN 
	SELECT d.department_id id 
	INTO vdept_id		-- 조회결과 저장할 변수
	FROM departments d
	WHERE d.DEPARTMENT_NAME = 'Sales';

	SELECT DEPARTMENT_ID id, max(salary) 
	INTO dept_id, max_sal 
		FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID
		HAVING DEPARTMENT_ID = vdept_id;
END;

-- 실행할 때 출력 매개 변수를 선언해야합니다.
DECLARE
		dept_id hr.employees.department_id %TYPE;
		max_sal NUMBER;
BEGIN
dept_max_salary2('Sales',dept_id,max_sal);
DBMS_OUTPUT.PUT_LINE('부서명' || ':'|| ',연봉금액 : ' || max_sal);
END;

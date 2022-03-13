-- ������ �������� : 1) �ٸ� ��ǻ�ͷ� �����ͺ��̽� ���̺�(������ ����)�� ������ ��,
--				 2) ���� ��ǻ���� �ٸ� ��Ű���� �����ͺ��̽� ���̺�(������ ����) ������ ��.

-- ��ũ��Ʈ ����(.sql) �� ���̺������ ������ �߰��ϱ�
-- 			1) DDL(create) �� DML(insert) �� ��� �ʿ��մϴ�.
--			2) DDL�� ���̺� properties ���� �����ϰ�
--			3) insert �����ʹ� ������ ��������� �մϴ�.
--			4) ���̺� �������� ���� ���� ������ �� ����ϼ���.

-- ���� : SQL > @���ϸ�.sql �� ���� �����մϴ�.
--	  	üũ���� 1) ���� ���丮 ��� - ������ �ִ� ��ġ���� cmd �����մϴ�.-> sqlplus �Է�
-- 			   2) @ ��ȣ �� ���ּ���. ���ϸ� ��Ȯ�� �ϼ���.

/* C:\Users\USER\Desktop>sqlplus

   SQL*Plus: Release 11.2.0.2.0 Production on ȭ 2�� 15 13:10:45 2022  

   Copyright (c) 1982, 2014, Oracle.  All rights reserved.  

Enter user-name: teamX
Enter password:  */

CREATE TABLE "EMPLOYEES" 
   (	"EMPLOYEE_ID" NUMBER(6,0), 
	"FIRST_NAME" VARCHAR2(20), 
	"LAST_NAME" VARCHAR2(25) CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(25) CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE, 
	"PHONE_NUMBER" VARCHAR2(20), 
	"HIRE_DATE" DATE CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE, 
	"JOB_ID" VARCHAR2(10) CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE, 
	"SALARY" NUMBER(8,2), 
	"COMMISSION_PCT" NUMBER(2,2), 
	"MANAGER_ID" NUMBER(6,0), 
	"DEPARTMENT_ID" NUMBER(4,0), 
	CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID")
);


CREATE TABLE "DEPARTMENTS" 
   (	"DEPARTMENT_ID" NUMBER(4,0), 
	"DEPARTMENT_NAME" VARCHAR2(30) CONSTRAINT "DEPT_NAME_NN" NOT NULL ENABLE, 
	"MANAGER_ID" NUMBER(6,0), 
	"LOCATION_ID" NUMBER(4,0), 
	 CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID")
);
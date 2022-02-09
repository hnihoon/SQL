-- UPDATE ����
-- UPDATE ���̺��
-- SET ������ �÷��̸�=�� �� ,�� �����ؼ� ����
-- WHERE ������ �࿡ ���� ���ǽ�

SELECT * FROM "TBL_CUSTOM#" tc ;

-- UPDATE�� DELETE �� where ���ǽ��� ���Ǵ� ���� �����մϴ�.
UPDATE "TBL_CUSTOM#" 
SET AGE =39
WHERE CUSTOM_ID ='twice';
--�⺻Ű �÷���� ���ǽ��� 1�� �ุ �����˴ϴ�.

UPDATE "TBL_CUSTOM#" 
SET age=23 , EMAIL = 'nana@korea.kr'
WHERE CUSTOM_ID = 'wonder';

--custom_id : wonder�� twice �� ����
--reg_date�� 2022�� 2�� 5�Ϸ� ����
UPDATE "TBL_CUSTOM#" 
SET REG_DATE = '2022-02-05'
WHERE CUSTOM_ID IN ('wonder','twice');	-- IN �����ڴ� OR ��ü

--DELETE ����
-- 	delete from ���̺�� where ���ǽ�;

DELETE FROM "TBL_PRODUCT#" tp WHERE PCODE = 'GAL0112';	-- ���� : buy#���� �������� �ʴ°�
DELETE FROM "TBL_PRODUCT#" tp WHERE pcode = 'IPAD011';  -- ���� : ���Ἲ ����

UPDATE "TBL_PRODUCT#" SET pname = '�����е�����'
WHERE PCODE = 'IPAD011';

UPDATE "TBL_PRODUCT#" SET pcode = 'IPAD0111'
WHERE PCODE = 'IPAD011';	-- ���� : buy#���� �����ϴ� ��(���Ἲ ����)

-- DELETE ����
-- delete from ���̺�� WHERE ���ǽ�;
-- ������ ���ѻ��õ����� �߰�
INSERT INTO "TBL_PRODUCT#"(PCODE ,CATEGORY ,PNAME ,PRICE)
VALUES ('GAL0112','A1','������20',912300);

SELECT * FROM "TBL_CUSTOM#" tc ;
SELECT * FROM "TBL_PRODUCT#" tp ;
SELECT * FROM "TBL_BUY#" tb ;

-- on DELETE, on UPDATE(����Ŭ�� �ȵ�) �Ӽ� �����Ͽ� �ܷ�Ű �ٽ� �����մϴ�.
ALTER TABLE IDEV."TBL_BUY#" 
			DROP CONSTRAINT "FK_TBL_PRODUCT#";
ALTER TABLE IDEV."TBL_BUY#" 
		 	ADD CONSTRAINT "FK_TBL_PRODUCT#" 
			FOREIGN KEY (PCODE)REFERENCES IDEV."TBL_PRODUCT#"(PCODE) 
			ON DELETE CASCADE;	
			-- ���Ἲ�� ���ؼ� �����ϴ°� ������ �����ϴ� �൵ ������(���޾Ƽ�)���� ����
-- ALTER TABLE ���� : drop, add, modify(���������� ���մϴ�.)
		
-- select �� join : �� �̻��� ���̺�(���������� ���̺�)�� �����Ͽ� �����͸� ��ȸ�ϴ� ���
-- �� �̻��� ���̺��� ����� �÷��� ���� �� �÷��� �̿��Ͽ� join�մϴ�.
-- ����:select ~~~ from ���̺�1 a, ���̺�2 b 
--				  WHERE a.�����÷�1=b.�����÷�1;

-- ����1
SELECT * FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
	WHERE tp.PCODE = tb.PCODE;		-- ���� ����.

-- join�� ���� ��ɹ� ����2(ǥ��)
SELECT * FROM "TBL_PRODUCT#" tp 
		JOIN "TBL_BUY#" tb 
		on tp.PCODE = tb.PCODE;
	
-- �ܺ����� ���� 2����
SELECT * FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
	WHERE tp.PCODE = tb.PCODE(+);		-- ���� ����.

-- join�� ���� ��ɹ� ����2(ǥ��)
SELECT * FROM "TBL_PRODUCT#" tp 
		LEFT OUTER JOIN "TBL_BUY#" tb  	-- ������ �Ǵ� ���̺��� ���� product#
		on tp.PCODE = tb.PCODE;

		

-- mina012 �� ������ ��ǰ���� �����ΰ�?
SELECT PNAME  FROM "TBL_PRODUCT#" tp 
		JOIN "TBL_BUY#" tb 
		on tp.PCODE = tb.PCODE
		WHERE CUSTOM_ID = 'mina012';
	
-- MINA012 �� ������ ��ǰ��� ���� ��ȸ�ϱ�
SELECT PNAME , PRICE  FROM "TBL_PRODUCT#" tp 
		JOIN "TBL_BUY#" tb 
		on tp.PCODE = tb.PCODE
		WHERE custom_id = 'mina012';
	
-- �����Ҷ� , ����� �÷��� ���̺���� �� �����ؾ� �մϴ�.
SELECT tp.PCODE , tp.PNAME  FROM "TBL_PRODUCT#" tp , "TBL_BUY#" tb 
	WHERE tp.PCODE = tb.PCODE AND custom_id = 'mina012';
	
	

-- ���̺��� ��� ������ �����ϱ�
TRUNCATE TABLE "TBL_BUY#"; 

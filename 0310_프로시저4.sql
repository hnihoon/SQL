-- ���ν����� begin ~ end; ������ SQL ��ɵ��� �������� ��찡 ��κ� �� �������� ��ɾ �ϳ��� ������ ó���մϴ�.
-- Ʈ������ : �ϳ��� ������ ó���ϴ� SQL ��ɹ� -> ��� �������Ǿ�� �մϴ�.(commit) �׷��� ������(�ϳ��� ������ �����)
-- 			�̹� ����� SQL����� ��Ұ� �Ǿ�� �մϴ�(rollback)

SELECT * FROM "TBL_PRODUCT#";
SELECT * FROM tbl_buy#;
-- ������ ���� : ���ν����� Ʈ����� ó��
-- tbl_buy# ���̺� ���ұݾ� money �÷��� �߰��ϰ� ��ǰ����X���� ����ؼ� ����.
SELECT * FROM "TBL_BUY#" tb;
ALTER TABLE "TBL_BUY#" ADD money number(8);

-- ó������1 : wonder ���� CHR-J59�� 2�� �����մϴ�.
INSERT INTO "TBL_BUY#"(BUT_SEQ,CUSTOM_ID,PCODE,QUANTITY,BUT_DATE)
VALUES(tbl_buy_SEQ.nextval,'wonder','CHR-J59',2,sysdate);
--ó������2 : dual �ӽ����̺� �̿��ؼ� ���� seq�� ���ϱ�
SELECT tbl_buy_seq.currval FROM dual;	--nextval �����Ŀ��� Ȯ�� ����.
-- ó������3 : ������ ��ǰ�� ���� ���ϱ�
SELECT price FROM "TBL_PRODUCT#" tp WHERE PCODE = 'CHR-J59';
-- ó������4 : ó������1���� �߰��� �࿡ money �÷� ����ϰ� ����.
UPDATE "TBL_BUY#" SET money = 98700*QUANTITY WHERE BUT_SEQ =82;

-- ���� Ʈ������� ���ν����� �����մϴ�.
CREATE OR REPLACE PROCEDURE proc_set_money(
	acustom_id IN varchar2,
	apcode IN varchar2,
	acnt IN NUMBER
)
IS 
	vseq NUMBER;	-- ��������
	vprice NUMBER;
BEGIN 
	INSERT INTO tbl_test VALUES (2,acustom_id);	-- Ʈ������� �ϳ��� ������ �ϰ� �ӽ����̺� �����͸� �߰�
	INSERT INTO "TBL_BUY#" (BUT_SEQ,CUSTOM_ID,PCODE,QUANTITY,BUT_DATE)
	VALUES (tbl_buy_seq.nextval,acustom_id,apcode,acnt,sysdate);	--�Ű����������� �߰�
	SELECT tbl_buy_seq.currval INTO vseq
		FROM dual;
	SELECT price INTO vprice 
		FROM "TBL_PRODUCT#" tp  WHERE PCODE = apcode;
UPDATE "TBL_BUY#" SET money = vprice * QUANTITY 
	WHERE BUT_SEQ = vseq;
	dbms_output.put_line('���� ����');
	COMMIT;
	EXCEPTION
	WHEN OTHERS THEN
	dbms_output.put_line('���� ����');
	ROLLBACK;
END;

-- ���ν��� ����
begin 
	proc_set_money('twice','C-BABQ1',4);	-- �����߻�(�������� �÷��� �߸��Ȱ����� �����մϴ�.)
END;

	SELECT * FROM "TBL_BUY#" tb ;

CREATE TABLE tbl_test(
	buy_seq number(8),
	custom_id varchar2(20)
);

SELECT * FROM TBL_TEST tt;


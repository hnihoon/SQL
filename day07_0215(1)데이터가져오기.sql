-- �����߿��� ������ȸ�� ����


-- ��ü ������ ������?
SELECT COUNT(*)  FROM tbl_camparea;

-- ������ ������ ������?
SELECT * FROM "tbl_campArea" tca
WHERE ADDRESS LIKE '������%';

-- ������ �ڵ����߿��� ��ȸ�ϱ�
SELECT * FROM "tbl_campArea" tca
WHERE CAMP_TYPE  LIKE '�ڵ���%'
AND aDDRESS LIKE '������%'; 

-- �ڵ��� �߿��� ������ 50�� �̻��� �� �߿����̸�, �ּ� ��ȸ�ϱ�
SELECT * FROM TBL_CAMPAREA tc
WHERE CAR_CNT >= 50;

-- ī��� �ִ� �߿��� �̸�, �ּ�, ī��� ���� ��ȸ�ϱ�
SELECT CAMP_NAME , ADDRESS , CARA_CNT  
FROM TBL_CAMPAREA tc
WHERE CARA_CNT > 0
ORDER BY ADDRESS;

SELECT DISTINCT substr(aDDRESS,1,instr(address,' ')) --substr(���ڿ�,������ġ,����)
FROM TBL_CAMPAREA tc;
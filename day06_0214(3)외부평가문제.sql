DROP TABLE MEMBER_TBL_02 IF EXISTS;		-- sql�� ���Ϸ� ������ �� ����ϼ���.

create table member_tbl_02(
    custno number(6) not null,
    custname varchar2(20),
    phone varchar2(13),
    address varchar2(60),
    joindate date,
    grade char(1),
    city char(2),
    primary key(custno)
);

create table money_tbl_02(
    custno number(6) not null,
    salenol number(8) not null,
    pcost number(8),
    amount number(4),
    price number(8),
    pcode varchar2(4),
    sdate date,
    primary key(custno,salenol)
);

--CREATE SEQUENCE member_seq INCREMENT BY 1
--START WITH 100001;
DROP SEQUENCE member_seq IF EXISTS;
CREATE SEQUENCE member_seq MINVALUE 100001;

SELECT * FROM member_tbl_02 ;
SELECT * FROM MONEY_TBL_02 mt ;

-- step 1) ȸ���� �����հ�
SELECT custno, sum(price) FROM MONEY_TBL_02 mt 
GROUP BY CUSTNO;

-- step 2) ���� ���� Ȯ���ϱ�
SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
GROUP BY CUSTNO
ORDER BY asum desc;

-- step 3) ������ ������������ join  
SELECT * FROM MEMBER_TBL_02 mt ,
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
WHERE mt.CUSTNO = sale.custno ;

-- step 4) �䱸���׿� ���� �ʿ��� �÷��� ��ȸ�ϱ�

SELECT mt.CUSTNO , CUSTNAME , grade, asum FROM MEMBER_TBL_02 mt ,
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
WHERE mt.CUSTNO = sale.custno ;


-- step 5) ������ �䱸���׿� ���� �÷���� �����ϱ�
SELECT mt.CUSTNO , CUSTNAME , 
		decode(grade,'A','VIP','B','�Ϲ�','C','����') AS agrade, 
		asum FROM MEMBER_TBL_02 mt ,
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
WHERE mt.CUSTNO = sale.custno ;

-- ���� ���� : "������ ���� ȸ���� ��ȸ���� �ʴ´�."�� "������ ���� ȸ���� 0���� ����Ѵ�."
--			1) null���� 0���� ����ϴ� �Լ� : nvl�Լ�   2)�ܺ��������� �����մϴ�.
--			3) �����հ谡 ���� ���� ȸ����ȣ ����(��������)�� ����մϴ�. (����:������ ��������)

SELECT mt.CUSTNO , CUSTNAME , 
		decode(grade,'A','VIP','B','�Ϲ�','C','����') AS agrade, 
		nvl(asum,0) AS sum_ FROM MEMBER_TBL_02 mt ,		--1)
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		) sale
WHERE mt.CUSTNO = sale.custno(+)   --2)
ORDER BY sum_ DESC,custno;		--3) asum �� ���� ���� custno ������ �մϴ�.

-- ���� 5)�� select ���� ����� �������̺� view �� �����մϴ�.
CREATE VIEW v_by_custno
as
SELECT mt.CUSTNO , CUSTNAME , 
		decode(grade,'A','VIP','B','�Ϲ�','C','����') AS agrade, 
		asum FROM MEMBER_TBL_02 mt ,
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
WHERE mt.CUSTNO = sale.custno ;


-- view �� ������� select ��������
SELECT * FROM V_BY_CUSTNO ;

-- ���α׷��� �˻� ��ɿ��� where �� �� ����ؼ� �����ؾ� �մϴ�.
SELECT * FROM V_BY_CUSTNO WHERE custno=100003;
SELECT * FROM V_BY_CUSTNO WHERE custname='�ֻ��';
SELECT * FROM V_BY_CUSTNO WHERE agrade='VIP';
SELECT * FROM V_BY_CUSTNO WHERE asum>4000;


-- 프로시저의 begin ~ end; 사이의 SQL 명령들이 여러개인 경우가 대부분 그 여러개의 명령어가 하나의 업무를 처리합니다.
-- 트랜젝션 : 하나의 업무를 처리하는 SQL 명령문 -> 모두 정상실행되어야 합니다.(commit) 그렇지 않으면(하나라도 오류가 생기면)
-- 			이미 실행된 SQL명령은 취소가 되어야 합니다(rollback)

SELECT * FROM "TBL_PRODUCT#";
SELECT * FROM tbl_buy#;
-- 오늘의 주제 : 프로시저로 트랜잭션 처리
-- tbl_buy# 테이블에 지불금액 money 컬럼을 추가하고 상품가격X수량 계산해서 저장.
SELECT * FROM "TBL_BUY#" tb;
ALTER TABLE "TBL_BUY#" ADD money number(8);

-- 처리순서1 : wonder 고객이 CHR-J59를 2개 구입합니다.
INSERT INTO "TBL_BUY#"(BUT_SEQ,CUSTOM_ID,PCODE,QUANTITY,BUT_DATE)
VALUES(tbl_buy_SEQ.nextval,'wonder','CHR-J59',2,sysdate);
--처리순서2 : dual 임시테이블 이용해서 현재 seq값 구하기
SELECT tbl_buy_seq.currval FROM dual;	--nextval 실행후에만 확인 가능.
-- 처리순서3 : 구매한 상품의 가격 구하기
SELECT price FROM "TBL_PRODUCT#" tp WHERE PCODE = 'CHR-J59';
-- 처리순서4 : 처리순서1에서 추가된 행에 money 컬럼 계산하고 저장.
UPDATE "TBL_BUY#" SET money = 98700*QUANTITY WHERE BUT_SEQ =82;

-- 위의 트랜잭션을 프로시저로 생성합니다.
CREATE OR REPLACE PROCEDURE proc_set_money(
	acustom_id IN varchar2,
	apcode IN varchar2,
	acnt IN NUMBER
)
IS 
	vseq NUMBER;	-- 변수선언
	vprice NUMBER;
BEGIN 
	INSERT INTO tbl_test VALUES (2,acustom_id);	-- 트랜잭션의 하나로 가정을 하고 임시테이블에 데이터를 추가
	INSERT INTO "TBL_BUY#" (BUT_SEQ,CUSTOM_ID,PCODE,QUANTITY,BUT_DATE)
	VALUES (tbl_buy_seq.nextval,acustom_id,apcode,acnt,sysdate);	--매개변수값으로 추가
	SELECT tbl_buy_seq.currval INTO vseq
		FROM dual;
	SELECT price INTO vprice 
		FROM "TBL_PRODUCT#" tp  WHERE PCODE = apcode;
UPDATE "TBL_BUY#" SET money = vprice * QUANTITY 
	WHERE BUT_SEQ = vseq;
	dbms_output.put_line('실행 성공');
	COMMIT;
	EXCEPTION
	WHEN OTHERS THEN
	dbms_output.put_line('실행 실패');
	ROLLBACK;
END;

-- 프로시저 실행
begin 
	proc_set_money('twice','C-BABQ1',4);	-- 오류발생(참조관계 컬럼에 잘못된값으로 실행합니다.)
END;

	SELECT * FROM "TBL_BUY#" tb ;

CREATE TABLE tbl_test(
	buy_seq number(8),
	custom_id varchar2(20)
);

SELECT * FROM TBL_TEST tt;


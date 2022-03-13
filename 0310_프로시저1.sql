-- 프로시저의 기본형식
DECLARE 	-- 변수선언
--	vcustomid varchar2(20);
--	vage number(3,0);
	vcustomid tbl_custom#.custom_id %TYPE;  -- 테이블명.컬럼명 로 지정된 타입과 같게 합니다.
	vage tbl_custom#.age %TYPE;
BEGIN 		-- 프로시저 시작
	-- 프로시저 내부에는 주로 DML 명령문들을 작성.(함계 실행해야할 여러 SQL : 트랜잭션)
	SELECT custom_id,age
	INTO vcustomid, vage -- 프로시저 구문 : 검색결과를 변수에 저장
	FROM "TBL_CUSTOM#" tc 
	WHERE CUSTOM_ID = 'mina012';
	-- 변수값을 콘솔에 출력
	DBMS_OUTPUT.PUT_LINE('고객이름 : ' || vcustomid);
	DBMS_OUTPUT.PUT_LINE('고객이름 : ' || vage);
	EXCEPTION 	--	예외(오류)처리
	WHEN no_data_found THEN	-- 예외 이름은 다양합니다. OTHERS 예외는 모든 경우
		DBMS_OUTPUT.put_line('찾는 데이터가 없습니다.');
END;			-- 끝
-- 전국야영장 정보조회와 예약


-- 전체 데이터 갯수는?
SELECT COUNT(*)  FROM tbl_camparea;

-- 강원도 데이터 갯수는?
SELECT * FROM "tbl_campArea" tca
WHERE ADDRESS LIKE '강원도%';

-- 강원도 자동차야영장 조회하기
SELECT * FROM "tbl_campArea" tca
WHERE CAMP_TYPE  LIKE '자동차%'
AND aDDRESS LIKE '강원도%'; 

-- 자동차 야영장 갯수가 50개 이상인 곳 야영장이름, 주소 조회하기
SELECT * FROM TBL_CAMPAREA tc
WHERE CAR_CNT >= 50;

-- 카라반 있는 야영장 이름, 주소, 카라반 갯수 조회하기
SELECT CAMP_NAME , ADDRESS , CARA_CNT  
FROM TBL_CAMPAREA tc
WHERE CARA_CNT > 0
ORDER BY ADDRESS;

SELECT DISTINCT substr(aDDRESS,1,instr(address,' ')) --substr(문자열,시작위치,길이)
FROM TBL_CAMPAREA tc;